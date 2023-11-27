const std = @import("std");
const database = @import("db.zig");
const user = @import("accounts.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    defer std.debug.assert(gpa.deinit() == .ok);

    var db = try database.DB.init(allocator);
    defer db.deinit(allocator);
    
    var out: [32]u8 = undefined;

    user.AccountManager.sha256("paris", &out);

    try db.accs.register("theo", .{
        .password = out,
    });

    try db.run(allocator);
}
