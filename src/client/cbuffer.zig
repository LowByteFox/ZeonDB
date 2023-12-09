const std = @import("std");

extern "c" fn memcpy(*anyopaque, *anyopaque, usize) callconv(.C) ?*anyopaque;

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
            var buffer: ?[*c]u8 = @ptrCast(std.c.malloc(size));
            if (buffer) |buf| {
                self.buffer = buf;
                self.size = 0;
                self.allocated = size;
            }
        }
    }

    pub fn append(self: *CBuffer, target: *CBuffer) void {
        const extra_space = -(self.allocated - self.size - target.size);
        if (extra_space > 0) {
            self.buffer = @ptrCast(std.c.realloc(self.allocated + extra_space));
        }
        memcpy(self.buffer + self.size, target.buffer, target.size);
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
        var buffer: ?[*c]u8 = @ptrCast(std.c.malloc(slice.len));
        if (buffer) |buf| {
            for (slice, 0..) |char, i| {
                buffer[i] = char;
            }

            return .{
                .buffer = buf,
                .size = slice.len,
                .allocated = slice.len,
            };
        }
        return null;
    }
};
