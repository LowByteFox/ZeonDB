const std = @import("std");
const context = @import("ctx.zig");
const types = @import("../types.zig");

fn set(ctx: *context.ZqlContext, allocator: std.mem.Allocator) anyerror!void {
    var arg1 = ctx.get_arg(0).?;
    var arg2 = ctx.get_arg(1).?;
    ctx.sweep_arg(0);
    try ctx.db.add(arg1.String, arg2, allocator);
}

fn get(ctx: *context.ZqlContext, allocator: std.mem.Allocator) anyerror!void {
    _ = allocator;
    ctx.buffer = ctx.db.get(ctx.get_arg(0).?.String).?;
}

pub const commands = std.ComptimeStringMap(context.ZqlCmd, .{
    .{
        "set", context.ZqlCmd{ .arg_count = 2, .func = set },
    },
    .{
        "get", context.ZqlCmd{ .arg_count = 1, .func = get },
    },
});
