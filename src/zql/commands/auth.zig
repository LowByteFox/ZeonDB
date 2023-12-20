const std = @import("std");
const context = @import("../ctx.zig");
const types = @import("../../types.zig");
const collection = @import("../../collection.zig");
const accs = @import("../../accounts.zig");
const mem = @import("memory");

fn perm_to_collection(perm: accs.Permission, allocator: std.mem.Allocator) !*types.Value {
    var v = try allocator.create(types.Value);
    v.* = .{ .Collection = try collection.Collection.init(allocator) };
    var read = try mem.AutoPtr(types.Value).init(allocator, .{ .Bool = perm.can_read });
    defer read.deinit();
    var write = try mem.AutoPtr(types.Value).init(allocator, .{ .Bool = perm.can_write });
    defer write.deinit();

    read.set_on_free(&types.dispose);
    write.set_on_free(&types.dispose);

    try v.Collection.add("can_read", read.move(), allocator);
    try v.Collection.add("can_write", write.move(), allocator);
    return v;
}

fn auth_get(ctx: *context.ZqlContext, allocator: std.mem.Allocator) anyerror!void {
    var arg1 = ctx.get_arg(1).?;
    const user = ctx.get_user();
    var perm = try ctx.db.get_perm(user, "$", allocator);

    if (std.mem.eql(u8, arg1.String[0..1], "$")) {
        var v = try perm_to_collection(perm.?, allocator);
        ctx.buffer = v;
        ctx.free_buffer = .{ .free = true, .deinit = true };
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

            var v = try perm_to_collection(perm.?, allocator);
            ctx.buffer = v;
            ctx.free_buffer = .{ .free = true, .deinit = true };
            break;
        }

        if (current.get(s)) |cur| {
            var tmp_perm = try current.get_perm(user, s, allocator);

            if (tmp_perm) |p| {
                perm = p;
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
        ctx.err = try std.fmt.allocPrint(allocator, "No such key \"{s}\"!", .{arg1.String});
        break;
    }

}

pub fn auth(ctx: *context.ZqlContext, allocator: std.mem.Allocator) anyerror!void {
    switch (ctx.get_arg_count()) {
        else => {
            ctx.err = try std.fmt.allocPrint(allocator, \\auth (subcommand) [...]
                \\get <path> -- return permissions set on specific path
                \\set <user@path> <perm> -- set premissions on specific path
                \\user is optional, if specified, the user will be affected
                \\perm is Collection with keys write and read as booleans
                , .{});
        },
        2 => {
            ctx.sweep_arg(0);
            ctx.sweep_arg(1);

            var arg1 = ctx.get_arg(0).?;

            switch (arg1.*) {
                types.Value.String => {},
                else => {
                    ctx.err = try std.fmt.allocPrint(allocator, "Argument 0 is not a String!", .{});
                    return;
                }
            }

            if (arg1.String.len >= 3 and std.mem.eql(u8, arg1.String, "get")) {
                try auth_get(ctx, allocator);
            }
        },
        3 => {
            ctx.sweep_arg(0);
            ctx.sweep_arg(1);
            ctx.sweep_arg(2);
        }
    }
}
