const std = @import("std");
const collection = @import("collection.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    defer std.debug.assert(gpa.deinit() == .ok);

    var db = try collection.Collection.init(allocator);
    defer db.deinit(allocator);

    var arr = std.ArrayList(collection.RawValue).init(allocator);

    try arr.append(collection.RawValue{
        .t = collection.Types.Int,
        .v = collection.Value{
            .i = 69
        }
    });

    try arr.append(collection.RawValue{
        .t = collection.Types.String,
        .v = collection.Value{
            .s = "Now this is pog"
        }
    });

    try db.add("arr", collection.Types.Array, collection.Value{
        .a = arr
    }, allocator);

    if (db.get("arr")) |ar| {
        for (ar.v.a.items) |item| {
            switch (item.t) {
                collection.Types.String => {
                    std.debug.print("{s}\n", .{item.v.s});
                },
                collection.Types.Int => {
                    std.debug.print("{}\n", .{item.v.i});
                },
                else => {}
            }
        }
    }
}
