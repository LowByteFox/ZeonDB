const std = @import("std");
const collection = @import("collection.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    defer std.debug.assert(gpa.deinit() == .ok);

    var db = try collection.Collection.init(allocator);
    defer db.deinit(allocator);

    var db2 = try collection.Collection.init(allocator);
    defer db2.deinit(allocator);

    try db.add("json", collection.Types.Collection, collection.Value{
        .c = db2
    }, allocator);

    try db2.add("number", collection.Types.Int, collection.Value{
        .i = 69
    }, allocator);

    // json test haha
    if (db.get("json")) |obj| {
        if (obj.value.c.get("number")) |num| {
            std.debug.print("{}\n", .{num.value.i});
        }
    }
}
