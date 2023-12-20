const std = @import("std");
const context = @import("../ctx.zig");
const types = @import("../../types.zig");
const collection = @import("../../collection.zig");
const mem = @import("memory");

pub fn get(ctx: *context.ZqlContext, allocator: std.mem.Allocator) anyerror!void {
    if (ctx.get_arg_count() != 1) {
        ctx.err = try std.fmt.allocPrint(allocator, "Expected 1 argument, got {}!", .{ctx.get_arg_count()});
        return;
    }

    var arg1 = ctx.get_arg(0).?;
    defer arg1.deinit();

    const user = ctx.get_user();
    var perm = try ctx.db.get_perm(user, "$", allocator);

    if (!perm.?.can_read) {
        ctx.err = try std.fmt.allocPrint(allocator, "Permissions denied, unable to read!", .{});
        return;
    }

    if (std.mem.eql(u8, arg1.value.String[0..1], "$")) {
        var v = try mem.AutoPtr(types.Value).init(allocator, .{ .Collection = ctx.db.* });
        defer v.deinit();
        v.set_on_free(types.dispose);
        ctx.buffer = v.move();
        return;
    }

    var split = std.mem.splitScalar(u8, arg1.value.String, '.');
    var current = ctx.db;

    while (split.next()) |s| {
        if (split.peek() == null) {
            var tmp_perm = try current.get_perm(user, s, allocator);

            if (tmp_perm) |p| {
                perm = p;
            }

            if (!perm.?.can_read) {
                ctx.err = try std.fmt.allocPrint(allocator, "Permissions denied, unable to read!", .{});
                return;
            }

            var val = current.get(s);

            if (val) |v| {
                defer v.deinit();
                ctx.buffer = v.move();
            } else {
                ctx.err = try std.fmt.allocPrint(allocator, "No such key \"{s}\"!", .{arg1.value.String});
            }
            break;
        }

        if (current.get(s)) |cur| {
            var tmp_perm = try current.get_perm(user, s, allocator);

            if (tmp_perm) |p| {
                perm = p;
            }

            if (!perm.?.can_read) {
                ctx.err = try std.fmt.allocPrint(allocator, "Permissions denied, unable to read!", .{});
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
        ctx.err = try std.fmt.allocPrint(allocator, "No such key \"{s}\"!", .{arg1.value.String});
        break;
    }
}
