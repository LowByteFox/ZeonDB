const std = @import("std");
const network = @import("networking");
const api = @import("api.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    _ = allocator;

    defer std.debug.assert(gpa.deinit() == .ok);

    var zeon = api.zeon_connection_init("127.0.0.1", 6748).?;
    defer api.zeon_connection_deinit(zeon);

    std.debug.print("{}\n", .{api.zeon_connection_auth(zeon, "theo", "paris2")});
    std.debug.print("{}\n", .{api.zeon_connection_auth(zeon, "theo", "paris")});
}
