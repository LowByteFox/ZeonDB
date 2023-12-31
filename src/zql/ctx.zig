const std = @import("std");
const types = @import("../types.zig");
const collection = @import("../collection.zig");
const err = @import("errors.zig");
const mem = @import("memory");

pub const ZqlFunc = *const fn (ctx: *ZqlContext, allocator: std.mem.Allocator) anyerror!void;

pub const ZqlContextErr = error {
    FunctionNotSet
};

pub const ZqlTrace = struct {
    value: ?*mem.AutoPtr(types.Value),
    err: ?[]u8,
};

// ZqlContext is used to hold context data for a function
// or exception if happened
pub const ZqlContext = struct {
    db: *collection.Collection,
    args: std.ArrayList(ZqlTrace),
    func: ?ZqlFunc,
    buffer: ?*mem.AutoPtr(types.Value),
    user: ?[]const u8,
    err: ?[]u8,
    
    pub fn init(db: *collection.Collection, allocator: std.mem.Allocator) ZqlContext {
        return ZqlContext{
            .db = db,
            .args = std.ArrayList(ZqlTrace).init(allocator),
            .func = null,
            .buffer = null,
            .err = null,
            .user = null,
        };
    }

    pub fn deinit(self: *ZqlContext) void {
        for (self.args.items) |arg| {
            if (arg.value) |v| {
                v.deinit();
            }
        }
        self.args.deinit();
    }

    pub fn set_user(self: *ZqlContext, username: []const u8) void {
        self.user = username; 
    }

    pub fn get_user(self: *ZqlContext) []const u8 {
        return self.user.?;
    }

    pub fn add_arg(self: *ZqlContext, arg: ZqlTrace) !void {
        try self.args.append(arg);
    }

    pub fn get_arg(self: *const ZqlContext, index: usize) ?*mem.AutoPtr(types.Value) {
        if (index > self.args.items.len) return null;

        return self.args.items[index].value;
    }

    pub fn get_arg_count(self: *const ZqlContext) usize {
        return self.args.items.len;
    }

    pub fn set_fn(self: *ZqlContext, func: ZqlFunc) void {
        self.func = func;
    }

    pub fn execute(self: *ZqlContext, buff: ?*mem.AutoPtr(types.Value), allocator: std.mem.Allocator) !?[]u8 {
        if (buff) |b| {
            self.buffer = b;
        }

        for (self.args.items) |a| {
            if (a.err) |e| {
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
