const std = @import("std");
const context = @import("ctx.zig");
const types = @import("../types.zig");
const collection = @import("../collection.zig");
const accs = @import("../accounts.zig");

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
            try current.assign_perm(user, s, perm.?, allocator);
            try current.add(s, arg2, allocator);
            break;
        }

        if (current.get(s)) |cur| {
            perm = try current.get_perm(user, s, allocator);

            if (!perm.?.can_write) {
                ctx.err = try std.fmt.allocPrint(allocator, "Permissions denied, unable to write!", .{});
                return;
            }
            current = &cur.Collection;
            continue;
        }

        var v = try allocator.create(types.Value);
        v.* = .{ .Collection = try collection.Collection.init(allocator) };
        try current.assign_perm(user, s, perm.?, allocator);
        try current.add(s, v, allocator);
        current = &v.Collection;
    }
}

fn allocate_value(val: types.Value, allocator: std.mem.Allocator) !*types.Value {
    var v = try allocator.create(types.Value);
    v.* = val;
    return v;
}

fn perm_to_collection(perm: accs.Permission, allocator: std.mem.Allocator) !*types.Value {
    var v = try allocator.create(types.Value);
    v.* = .{ .Collection = try collection.Collection.init(allocator) };
    try v.Collection.add("can_read", try allocate_value(.{ .Bool = perm.can_read }, allocator),allocator);
    try v.Collection.add("can_write", try allocate_value(.{ .Bool = perm.can_write }, allocator),allocator);
    return v;
}

fn auth(ctx: *context.ZqlContext, allocator: std.mem.Allocator) anyerror!void {
    switch (ctx.get_arg_count()) {
        else => {
            ctx.err = try std.fmt.allocPrint(allocator, \\auth (subcommand) [...]
                \\get <path> -- return permissions set on that specific path
                , .{});
        },
        1 => {
            var arg1 = ctx.get_arg(0).?;
            ctx.sweep_arg(0);

            if (std.mem.eql(u8, arg1.String[0..1], "$")) {
                const user = ctx.get_user();
                var perm = try ctx.db.get_perm(user, "$", allocator);
                var v = try perm_to_collection(perm.?, allocator);
                ctx.buffer = v;
                ctx.free_buffer = .{ .free = true, .deinit = true };
                return;
            }
        }
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
            perm = try ctx.db.get_perm(user, s, allocator);

            if (!perm.?.can_read) {
                ctx.err = try std.fmt.allocPrint(allocator, "Permissions denied, unable to read!", .{});
                return;
            }

            var val = current.get(s);
            if (val) |v| {
                ctx.buffer = v;
            } else {
                ctx.err = try std.fmt.allocPrint(allocator, "No such key \"{s}\"!", .{arg1.String});
            }
            break;
        }

        if (current.get(s)) |cur| {
            perm = try ctx.db.get_perm(user, s, allocator);

            if (!perm.?.can_read) {
                ctx.err = try std.fmt.allocPrint(allocator, "Permissions denied, unable to read!", .{});
                return;
            }

            current = &cur.Collection;
            continue;
        }
        ctx.err = try std.fmt.allocPrint(allocator, "No such key \"{s}\"!", .{arg1.String});
        break;
    }
}

pub const commands = std.ComptimeStringMap(context.ZqlFunc, .{
    .{
        "set", set,
    },
    .{
        "get", get,
    },
    .{
        "auth", auth,
    }
});
