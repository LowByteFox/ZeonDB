const std = @import("std");
const parser = @import("zql/parser.zig");
const collection = @import("collection.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    defer std.debug.assert(gpa.deinit() == .ok);

    var db = try collection.Collection.init(allocator);
    defer db.deinit(allocator);

//    var p = parser.Parser.init(&db,
//                               \\set ahoj cau
//                               \\set clovek {
//                               \\   meno fero
//                               \\   priezvisko turcik
//                               \\   info ["sietar" "admin" "smetiar"]
//                               \\   rodina {
//                               \\       otec true
//                               \\       mama true
//                               \\   }
//                               \\}
//                              );
    var p = parser.Parser.init(&db,
                               \\test hello { -- object start
                               \\   hello ["world", {
                               \\       inner true
                               \\   }] -- array with object
                               \\   hello2: hey
                               \\   nice zig,
                               \\   num1 74
                               \\   float1: "5",
                               \\   float2 3.14 -- math pi
                               \\}
                              );
    try p.run(allocator);
}
