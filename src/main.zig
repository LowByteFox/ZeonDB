const std = @import("std");
const collection = @import("collection.zig");
const config = @import("config.zig");
const network = @import("networking/loop.zig");
const accounts = @import("accounts.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    defer std.debug.assert(gpa.deinit() == .ok);

    var db = try collection.Collection.init(allocator);
    defer db.deinit(allocator);

    var parsed = try config.load_config(allocator);
    defer parsed.deinit();

    var server = try network.Server.init(6748);
    defer server.deinit();

    // try server.run(&db, &allocator)

    var account_manager = try accounts.AccountManager.init(allocator);
    defer account_manager.deinit();

    try account_manager.register("qra", .{ .password = @ptrCast(@constCast("adamvojtko")) });

    std.debug.print("{}\n", .{account_manager.login("qra", "adam")});
    std.debug.print("{}\n", .{account_manager.login("qra", "adamuojtko")});
    std.debug.print("{}\n", .{account_manager.login("qra", "adamvojtko")});
    std.debug.print("{}\n", .{account_manager.login("qra", "adamvojtko123")});
}
