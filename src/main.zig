const std = @import("std");
const collection = @import("collection.zig");
const config = @import("config.zig");
const network = @import("networking/loop.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    defer std.debug.assert(gpa.deinit() == .ok);

    var db = try collection.Collection.init(allocator);
    defer db.deinit(allocator);

    var parsed = try config.load_config(allocator);
    defer parsed.deinit();


    var server = try network.Server.init(6969);
    defer server.deinit();

    try server.run();
}
