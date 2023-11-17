const std = @import("std");
const context = @import("ctx.zig");
const types = @import("../types.zig");
const collection = @import("../collection.zig");

fn set(ctx: *context.ZqlContext, allocator: std.mem.Allocator) anyerror!void {
    var arg1 = ctx.get_arg(0).?;
    var arg2 = ctx.get_arg(1).?;
    ctx.sweep_arg(0);

    var split = std.mem.splitScalar(u8, arg1.String, '.');
    var current = ctx.db;

    while (split.next()) |s| {
        if (split.peek() == null) {
            try current.add(s, arg2, allocator);
            break;
        }
        if (current.get(s)) |cur| {
            current = &cur.Collection;
            continue;
        }
        var v = try allocator.create(types.Value);
        v.* = .{ .Collection = try collection.Collection.init(allocator) };
        try current.add(s, v, allocator);
        current = &v.Collection;
    }
}

fn get(ctx: *context.ZqlContext, allocator: std.mem.Allocator) anyerror!void {
    ctx.sweep_arg(0);
    var args1 = ctx.get_arg(0).?.String;
    _ = args1;
    var val = ctx.db.get(ctx.get_arg(0).?.String);
    if (val) |v| {
        ctx.buffer = v;
    } else {
        ctx.err = try std.fmt.allocPrint(allocator, "No such key \"{s}\"!", .{ctx.get_arg(0).?.String});
    }
}

pub const commands = std.ComptimeStringMap(context.ZqlCmd, .{
    .{
        "set", context.ZqlCmd{ .arg_count = 2, .func = set },
    },
    .{
        "get", context.ZqlCmd{ .arg_count = 1, .func = get },
    },
});
