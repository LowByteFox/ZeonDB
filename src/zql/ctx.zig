const std = @import("std");
const types = @import("../types.zig");
const collection = @import("../collection.zig");

pub const ZqlContext = struct {
    db: *collection.Collection,
    args: std.ArrayList(*types.Value),
    
    pub fn init(db: *collection.Collection, allocator: std.mem.Allocator) ZqlContext {
        return ZqlContext{
            .db = db,
            .args = std.ArrayList(*types.Value).init(allocator)
        };
    }

    pub fn deinit(self: *ZqlContext) void {
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
};

pub const ZqlCmd = struct {
    arg_count: i32,
    func: *const fn (ctx: *const ZqlContext, allocator: std.mem.Allocator) anyerror!void
};
