const std = @import("std");
const database = @import("db.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    defer std.debug.assert(gpa.deinit() == .ok);

    var db = try database.DB.init(allocator);
    defer db.deinit(allocator);

    try db.run(allocator);
}
