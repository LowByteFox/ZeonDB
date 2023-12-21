const std = @import("std");

extern "c" fn memcpy(*anyopaque, *anyopaque, usize) callconv(.C) ?*anyopaque;
extern "c" fn malloc(size: usize) ?[*]u8;

pub const CBuffer = extern struct {
    buffer: [*c]u8,
    size: usize,
    allocated: usize,

    pub fn init() CBuffer {
        return .{
            .buffer = null,
            .size = 0,
            .allocated = 0,
        };
    }

    pub fn create(self: *CBuffer, size: usize) void {
        if (self.allocated == 0 and self.buffer == null) {
            var buffer: ?[*c]u8 = malloc(size);
            if (buffer) |buf| {
                self.buffer = buf;
                self.size = 0;
                self.allocated = size;
            }
        }
    }

    pub fn append(self: *CBuffer, target: *CBuffer) void {
        const extra_space = -(@as(isize, @intCast(self.allocated)) - 
                @as(isize, @intCast(self.size)) -
                @as(isize, @intCast(target.size)));
        if (extra_space > 0) {
            self.buffer = @ptrCast(std.c.realloc(self.buffer, self.allocated + @as(usize, @intCast(extra_space))));
        }
        _ = memcpy(self.buffer + self.size, target.buffer, target.size);
    }

    pub fn append_slice(self: *CBuffer, target: []u8) void {
        const extra_space = -(@as(isize, @intCast(self.allocated)) - 
                @as(isize, @intCast(self.size)) -
                @as(isize, @intCast(target.len)));
        if (extra_space > 0) {
            self.buffer = @ptrCast(std.c.realloc(self.buffer, self.allocated + @as(usize, @intCast(extra_space))));
        }
        _ = memcpy(self.buffer + self.size, @ptrCast(target), target.len);
    }

    pub fn deinit(self: *CBuffer) void {
        if (self.buffer) |buf| {
            std.c.free(buf);
        }
        self.size = 0;
        self.allocated = 0;
        self.buffer = null;
    }

    pub fn copy_onto(self: *CBuffer, buffer: []u8) void {
        @memcpy(buffer, self.buffer[0..self.size]);
    }

    pub fn from_slice(slice: []u8) ?CBuffer {
        var buffer: ?[*]u8 = malloc(slice.len);
        if (buffer) |buf| {
            for (slice, 0..) |char, i| {
                buf[i] = char;
            }
            buf[slice.len] = 0;

            return .{
                .buffer = buf,
                .size = slice.len,
                .allocated = slice.len,
            };
        }
        return null;
    }
};
