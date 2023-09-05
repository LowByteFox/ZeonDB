const std = @import("std");
const tk = @import("./tokens.zig");
const lexer = @import("./lexer.zig");
const ast = @import("./ast.zig");

pub const Parser = struct {
    lexer: lexer.Lexer,

    pub fn init(text: []const u8) Parser {
        return Parser{
            .lexer = lexer.Lexer.init(text)
        };
    }

    pub fn reset(self: *Parser, text: [*]u8) void {
        self.lexer = lexer.Lexer.init(text);
    }

    pub fn parse(self: *Parser, allocator: std.mem.Allocator) !std.ArrayList(ast.Node) {
        var arr = std.ArrayList(ast.Node).init(allocator);

        var tok = try self.lexer.generate_token(allocator);
        if (tok.t != tk.TokenTypes.identifier) {
            // FIX: Must be fixed 
            unreachable;
        }

        try self.parse_command(tok, &arr, allocator);

        while (tok.t != tk.TokenTypes.eof) {
            tok = try self.lexer.generate_token(allocator);
            if (tok.t == tk.TokenTypes.eof) {
                break;
            }
            try self.parse_command(tok, &arr, allocator);
        }

        allocator.free(tok.s);

        return arr;
    }

    fn parse_command(self: *Parser, tok: tk.Token, arr: *std.ArrayList(ast.Node), allocator: std.mem.Allocator) !void {
        var node = ast.Node.init("Command");
        try node.setToken(tok, allocator);
        try arr.append(node);
        allocator.free(tok.s);

        node = ast.Node.init("Key");
        var tok2 = try self.lexer.generate_token(allocator);
        try node.setToken(tok2, allocator);
        try arr.append(node);
        allocator.free(tok2.s);

        node = try self.parse_value(allocator);
        try arr.append(node);
    }

    fn parse_value(self: *Parser, allocator: std.mem.Allocator) !ast.Node {
        var tok = try self.lexer.generate_token(allocator);
        var node = ast.Node.init("Value");
        try node.setToken(tok, allocator);
        allocator.free(tok.s);

        return node;
    }
};
