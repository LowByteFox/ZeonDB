const std = @import("std");
const collection = @import("collection.zig");
const lex = @import("./parser/lexer.zig");
const tk = @import("./parser/tokens.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    defer std.debug.assert(gpa.deinit() == .ok);

    var db = try collection.Collection.init(allocator);
    defer db.deinit(allocator);

    try db.add("hyro", collection.Value{
        .Bool = true
    }, allocator);

    if (db.get("hyro")) |v| {
        std.debug.print("{?}", .{v});
    }
}
