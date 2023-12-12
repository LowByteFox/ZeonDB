const std = @import("std");
const types = @import("../types.zig");
const collection = @import("../collection.zig");
const err = @import("errors.zig");

pub const ZqlFunc = *const fn (ctx: *ZqlContext, allocator: std.mem.Allocator) anyerror!void;

pub const ZqlContextErr = error {
    FunctionNotSet
};

pub const MarkToSweep = struct {
    sweep: bool,
    ptr: *ZqlTrace,
};

pub const BufferMng = struct {
    free: bool,
    deinit: bool,
};

pub const ZqlTrace = struct {
    value: ?*types.Value,
    err: ?[]u8,
    free_value: BufferMng,
};

// ZqlContext is used to hold context data for a function
// or exception if happened
pub const ZqlContext = struct {
    db: *collection.Collection,
    args: std.ArrayList(MarkToSweep),
    func: ?ZqlFunc,
    buffer: ?*types.Value,
    free_buffer: BufferMng,
    user: ?[]u8,
    err: ?[]u8,
    
    pub fn init(db: *collection.Collection, allocator: std.mem.Allocator) ZqlContext {
        return ZqlContext{
            .db = db,
            .args = std.ArrayList(MarkToSweep).init(allocator),
            .func = null,
            .buffer = null,
            .err = null,
            .free_buffer = .{ .free = false, .deinit = false },
            .user = null,
        };
    }

    pub fn deinit(self: *ZqlContext, allocator: std.mem.Allocator) void {
        for (self.args.items) |arg| {
            if (arg.sweep) {
                if (arg.ptr.value) |v| {
                    types.dispose(v, allocator);
                }
            }
            allocator.destroy(arg.ptr);
        }
        self.args.deinit();
    }

    pub fn set_user(self: *ZqlContext, username: []const u8, allocator: std.mem.Allocator) !void {
        self.user = try allocator.alloc(u8, username.len);
        @memcpy(self.user.?, username);
    }

    pub fn get_user(self: *ZqlContext) []u8 {
        return self.user.?;
    }

    pub fn add_arg(self: *ZqlContext, arg: *ZqlTrace) !void {
        try self.args.append(.{ .ptr = arg, .sweep = false });
    }

    pub fn get_arg(self: *const ZqlContext, index: usize) ?*types.Value {
        if (index > self.args.items.len) return null;

        return self.args.items[index].ptr.value;
    }

    pub fn sweep_arg(self: *ZqlContext, index: usize) void {
        if (index > self.args.items.len) return;

        self.args.items[index].sweep = true;
    }

    pub fn get_arg_count(self: *const ZqlContext) usize {
        return self.args.items.len;
    }

    pub fn set_fn(self: *ZqlContext, func: ZqlFunc) void {
        self.func = func;
    }

    pub fn execute(self: *ZqlContext, buff: ?*types.Value, allocator: std.mem.Allocator) !?[]u8 {
        if (buff) |b| {
            self.buffer = b;
        }

        for (self.args.items) |a| {
            if (a.ptr.err) |e| {
                return e;
            }
        }

        if (self.func) |func| {
            try func(self, allocator);
            return null;
        }
        return ZqlContextErr.FunctionNotSet;
    }
};
