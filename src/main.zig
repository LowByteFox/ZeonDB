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

    var lexer = lex.Lexer.init("set users.hyro.isNice true \"xd\" 5 5.7");
    var tok = try lexer.generate_token(allocator);
    while (tok.t != tk.TokenTypes.eof) {
        std.debug.print("{?}\n", .{tok});
        allocator.free(tok.s);
        tok = try lexer.generate_token(allocator);
    }

    allocator.free(tok.s);
}
