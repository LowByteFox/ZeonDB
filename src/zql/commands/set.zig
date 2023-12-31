const std = @import("std");
const context = @import("../ctx.zig");
const types = @import("../../types.zig");
const collection = @import("../../collection.zig");
const mem = @import("memory");

pub fn set(ctx: *context.ZqlContext, allocator: std.mem.Allocator) anyerror!void {
    if (ctx.get_arg_count() != 2) {
        ctx.err = try std.fmt.allocPrint(allocator, "Expected 2 arguments, got {}!", .{ctx.get_arg_count()});
        return;
    }

    var arg1 = ctx.get_arg(0).?;
    var arg2 = ctx.get_arg(1).?;

    const user = ctx.get_user();
    var perm = try ctx.db.get_perm(user, "$", allocator);

    if (!perm.?.can_write) {
        ctx.err = try std.fmt.allocPrint(allocator, "Permissions denied, unable to write!", .{});
        return;
    }

    var split = std.mem.splitScalar(u8, arg1.value.String, '.');
    var current = ctx.db;

    while (split.next()) |s| {
        if (split.peek() == null) {
            try current.add(s, arg2.move(), allocator);
            break;
        }

        if (current.get(s)) |cur| {
            var tmp_perm = try current.get_perm(user, s, allocator);

            if (tmp_perm) |p| {
                perm = p;
            }

            if (!perm.?.can_write) {
                ctx.err = try std.fmt.allocPrint(allocator, "Permissions denied, unable to write!", .{});
                return;
            }

            switch (cur.value) {
                types.Value.Collection => {},
                else => {
                    ctx.err = try std.fmt.allocPrint(allocator, "Key \"{s}\" was expected to be Collection, but got {s}!", .{s, @tagName(cur.value)});
                    return;
                }
            }

            current = &cur.value.Collection;
            continue;
        }

        var v = try mem.AutoPtr(types.Value).init(allocator, .{ .Collection = try collection.Collection.init(allocator) });
        defer v.deinit();
        v.set_on_free(types.dispose);
        try current.add(s, v.move(), allocator);
        current = &v.value.Collection;
    }
}
