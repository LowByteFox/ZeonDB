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
        var n = ast.Node.init("Command");
        try n.setToken(tok, allocator);
        try arr.append(n);

        var is_key: bool = false;

        while (tok.t != tk.TokenTypes.eof) {
            allocator.free(tok.s);
            tok = try self.lexer.generate_token(allocator);
            if (tok.t == tk.TokenTypes.eof) break;
            if (!is_key) {
                n = ast.Node.init("Key");
                try n.setToken(tok, allocator);
                try arr.append(n);
                is_key = true;
                continue;
            }
            n = ast.Node.init("Value");
            try n.setToken(tok, allocator);
            try arr.append(n);
        }

        allocator.free(tok.s);

        return arr;
    }
};
