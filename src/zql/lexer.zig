const std = @import("std");

pub const TokenTypes = enum {
    eof,
    illegal,
    identifier,
    string,
    int,
    float,
    bool,
    colon,
    comma,
    lsquarebracket,
    rsquarebracket,
    lsquiglybracket,
    rsquiglybracket
};

pub const Token = struct {
    type: TokenTypes,
    text: []u8,
};

// Function that takes constant string and makes new allocated on the heap
// so i can free tokens as i go
fn allocate_str(string: []const u8, allocator: std.mem.Allocator) ![]u8 {
    var alloc = try allocator.alloc(u8, string.len);
    @memcpy(alloc, string);

    return alloc;
}

pub const LexerError = error {
    CannotGoBackwards
};

pub const Lexer = struct {
    str: [:0]const u8,
    pos: i32,
    len: usize,

    pub fn init(code: [:0]const u8) Lexer {
        return Lexer {
            .str = code,
            .pos = 0,
            .len = code.len
        };
    }

    fn read_char(self: *Lexer) u8 {
        if (self.pos - 1 == self.len) return 0;
        const ret = self.str[@intCast(self.pos)];
        self.pos += 1;

        return ret;
    }

    pub fn step_back(self: *Lexer, len: i32) LexerError!void {
        if (self.pos - len < 0) {
            return LexerError.CannotGoBackwards;
        }
        self.pos -= len;
    }

    fn skip_blank(self: *Lexer) !void {
        var current: u8 = self.read_char();
        while (current == ' ' or current == '\t' or current == '\n') {
            current = self.read_char();
        }
        try self.step_back(1);
    }

    fn skip_comment(self: *Lexer) !void {
        if (self.read_char() != '-') {
            try self.step_back(1);
            return;
        }
        var current: u8 = self.read_char();
        while (current != '\n') {
            current = self.read_char();
        }
    }

    fn tokenize_identifier(self: *Lexer, allocator: std.mem.Allocator) !Token {
        var tok: Token = undefined;
        tok.type = TokenTypes.identifier;

        var str: []u8 = try allocator.alloc(u8, 1);
        var current: u8 = self.read_char();

        while (std.ascii.isDigit(current) or std.ascii.isAlphabetic(current) or current == '_' or current == '$') {
            str[str.len - 1] = current;
            str = try allocator.realloc(str, str.len + 1);
            current = self.read_char();
        }

        str = try allocator.realloc(str, str.len - 1);

        try self.step_back(1);
        tok.text = str;

        if (str.len == 4 and std.mem.eql(u8, "true", str)) {
            tok.type = TokenTypes.bool;
        } else if (str.len == 5 and std.mem.eql(u8, "false", str)) {
            tok.type = TokenTypes.bool;
        }

        return tok;
    }

    fn tokenize_number(self: *Lexer, allocator: std.mem.Allocator) !Token {
        var tok: Token = undefined;
        tok.type = TokenTypes.int;

        var str: [] u8 = try allocator.alloc(u8, 1);
        var is_float: bool = false;

        var current = self.read_char();

        while (std.ascii.isDigit(current) or current == '.') {
            str[str.len - 1] = current;
            str = try allocator.realloc(str, str.len + 1);
            current = self.read_char();
            if (current == '.') {
                is_float = true;
                continue;
            }
            if (current == '.' and is_float) break;
        }
        str = try allocator.realloc(str, str.len - 1);
        try self.step_back(1);
        tok.text = str;

        if (is_float) {
            tok.type = TokenTypes.float;
        }

        return tok;
    }

    fn tokenize_string(self: *Lexer, to_end: u8, allocator: std.mem.Allocator) !Token {
        var tok: Token = undefined;
        tok.type = TokenTypes.string;
 
        var str: [] u8 = try allocator.alloc(u8, 1);

        var current = self.read_char();
        while (true) {
            var next: u8 = self.read_char();
            if (current == 0) break;
            if (current == '\\' and next == to_end) {
                str[str.len - 1] = to_end;
                str = try allocator.realloc(str, str.len + 1);
                str[str.len - 1] = to_end;
                current = self.read_char();
                continue;
            }
            try self.step_back(1);
            if (current == to_end) break;
            str[str.len - 1] = current;
            str = try allocator.realloc(str, str.len + 1);
            current = self.read_char();
        }
        str = try allocator.realloc(str, str.len - 1);
        tok.text = str;

        return tok;
    }

    pub fn parse_token(self: *Lexer, allocator: std.mem.Allocator) !Token {
        try self.skip_blank();
        const tok = self.read_char();

        if (tok == 0) {
            return Token{
                .type = TokenTypes.eof,
                .text = try allocate_str("EOF", allocator)
            };
        }

        switch (tok) {
            '"', '\'' => {
                return try self.tokenize_string(tok, allocator);
            },
            ':' => {
                return Token{
                    .text = try allocate_str(":", allocator),
                    .type = TokenTypes.colon
                };
            },
            ',' => {
                return Token{
                    .text = try allocate_str(",", allocator),
                    .type = TokenTypes.comma
                };
            },
            '[' => {
                return Token{
                    .text = try allocate_str("[", allocator),
                    .type = TokenTypes.lsquarebracket
                };
            },
            ']' => {
                return Token{
                    .text = try allocate_str("]", allocator),
                    .type = TokenTypes.rsquarebracket
                };
            },
            '{' => {
                return Token{
                    .text = try allocate_str("{", allocator),
                    .type = TokenTypes.lsquiglybracket
                };
            },
            '}' => {
                return Token{
                    .text = try allocate_str("}", allocator),
                    .type = TokenTypes.rsquiglybracket
                };
            },
            '-' => {
                try self.skip_comment();
                return self.parse_token(allocator);
            },
            else => {}
        }

        if (std.ascii.isAlphabetic(tok) or tok == '_') {
            try self.step_back(1);
            return try self.tokenize_identifier(allocator);
        } else if (std.ascii.isDigit(tok)) {
            try self.step_back(1);
            return try self.tokenize_number(allocator);
        } else {
            return Token{
                .text = try allocate_str("ILL", allocator),
                .type = TokenTypes.illegal
            };
        }
    }
};
