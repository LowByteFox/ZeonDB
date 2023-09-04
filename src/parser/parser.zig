const lexer = @import("./lexer.zig");

pub const Parser = struct {
    lexer: lexer.Lexer,

    pub fn init(text: []u8) Parser {
        return Parser{
            .lexer = lexer.Lexer.init(text)
        };
    }

    pub fn reset(self: *Parser, text: []u8) void {
        self.lexer = lexer.Lexer.init(text);
    }
};
