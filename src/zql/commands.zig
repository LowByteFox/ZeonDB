const std = @import("std");
const context = @import("ctx.zig");
const types = @import("../types.zig");
const collection = @import("../collection.zig");
const accs = @import("../accounts.zig");
const auth = @import("commands/auth.zig");

fn set(ctx: *context.ZqlContext, allocator: std.mem.Allocator) anyerror!void {
    if (ctx.get_arg_count() != 2) {
        ctx.err = try std.fmt.allocPrint(allocator, "Expected 2 arguments, got {}!", .{ctx.get_arg_count()});
        return;
    }

    var arg1 = ctx.get_arg(0).?;
    var arg2 = ctx.get_arg(1).?;
    ctx.sweep_arg(0);

    const user = ctx.get_user();
    var perm = try ctx.db.get_perm(user, "$", allocator);

    if (!perm.?.can_write) {
        ctx.err = try std.fmt.allocPrint(allocator, "Permissions denied, unable to write!", .{});
        return;
    }

    var split = std.mem.splitScalar(u8, arg1.String, '.');
    var current = ctx.db;

    while (split.next()) |s| {
        if (split.peek() == null) {
            try current.add(s, arg2, allocator);
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

            switch (cur.*) {
                types.Value.Collection => {},
                else => {
                    ctx.err = try std.fmt.allocPrint(allocator, "Key \"{s}\" was expected to be Collection, but got {s}!", .{s, @tagName(cur.*)});
                    return;
                }
            }

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
    if (ctx.get_arg_count() != 1) {
        ctx.err = try std.fmt.allocPrint(allocator, "Expected 1 argument, got {}!", .{ctx.get_arg_count()});
        return;
    }

    ctx.sweep_arg(0);
    var arg1 = ctx.get_arg(0).?;

    const user = ctx.get_user();
    var perm = try ctx.db.get_perm(user, "$", allocator);

    if (!perm.?.can_read) {
        ctx.err = try std.fmt.allocPrint(allocator, "Permissions denied, unable to read!", .{});
        return;
    }

    if (std.mem.eql(u8, arg1.String[0..1], "$")) {
        var v = try allocator.create(types.Value);
        v.* = .{ .Collection = ctx.db.* };
        ctx.buffer = v;
        ctx.free_buffer = .{ .free = true, .deinit = false };
        return;
    }

    var split = std.mem.splitScalar(u8, arg1.String, '.');
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
                ctx.buffer = v.value;
            } else {
                ctx.err = try std.fmt.allocPrint(allocator, "No such key \"{s}\"!", .{arg1.String});
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

            switch (cur.*) {
                types.Value.Collection => {},
                else => {
                    ctx.err = try std.fmt.allocPrint(allocator, "Key \"{s}\" was expected to be Collection, but got {s}!", .{s, @tagName(cur.*)});
                    return;
                }
            }

            current = &cur.Collection;
            continue;
        }
        ctx.err = try std.fmt.allocPrint(allocator, "No such key \"{s}\"!", .{arg1.String});
        break;
    }
}

pub const commands = std.ComptimeStringMap(context.ZqlFunc, .{
//    .{
//        "set", set,
//    },
//    .{
//        "get", get,
//    },
    .{
        "auth", auth.auth,
    }
});
