const std = @import("std");
const trie = @import("./trie.zig");
const types = @import("./types.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    defer std.debug.assert(gpa.deinit() == .ok);

    var db = try trie.Trie(types.Value).init(allocator);

    defer allocator.destroy(db);
    defer db.deinit(allocator);

    try db.add("s", types.Value{
        .type = types.Types.Int,
        .value = types.ValueU{
            .i = 69
        }
    }, allocator);

    var ops: i64 = 0;
    const start = std.time.milliTimestamp();
    while (std.time.milliTimestamp() - start < 1000) {
        if (db.get("s")) |V| {
            _ = V;
            ops += 1;
        }
    }

    std.debug.print("Read count: {}\n", .{ops});
}
