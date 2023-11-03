const std = @import("std");
const types = @import("../types.zig");
const collection = @import("../collection.zig");

pub const ZqlFunc = *const fn (ctx: *const ZqlContext, allocator: std.mem.Allocator) anyerror!void;

pub const ZqlContextErr = error {
    FunctionNotSet
};

// ZqlContext is used to hold context data for a function
pub const ZqlContext = struct {
    db: *collection.Collection,
    args: std.ArrayList(*types.Value),
    func: ?ZqlFunc,
    
    pub fn init(db: *collection.Collection, allocator: std.mem.Allocator) ZqlContext {
        return ZqlContext{
            .db = db,
            .args = std.ArrayList(*types.Value).init(allocator),
            .func = null
        };
    }

    pub fn deinit(self: *ZqlContext, allocator: std.mem.Allocator) void {
        for (self.args.items) |arg| {
            types.dispose(arg, allocator);
        }
        self.args.deinit();
    }

    pub fn add_arg(self: *ZqlContext, arg: *types.Value) !void {
        try self.args.append(arg);
    }

    pub fn get_arg(self: *const ZqlContext, index: usize) ?*types.Value {
        if (index > self.args.items.len) return null;

        return self.args.items[index];
    }

    pub fn get_arg_count(self: *const ZqlContext) usize {
        return self.args.items.len;
    }

    pub fn set_fn(self: *ZqlContext, func: ZqlFunc) void {
        self.func = func;
    }

    pub fn execute(self: *ZqlContext, allocator: std.mem.Allocator) !void {
        if (self.func) |func| {
            try func(self, allocator);
            return;
        }
        return ZqlContextErr.FunctionNotSet;
    }
};

pub const ZqlCmd = struct {
    arg_count: i32,
    func: ZqlFunc, 
};
