const std = @import("std");
const utils = @import("../utils.zig");

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
    text: []const u8,
    col: usize,
    line: usize,
};

pub const LexerError = error {
    CannotGoBackwards
};

pub const Lexer = struct {
    str: [:0]const u8,
    pos: usize,
    len: usize,
    col: usize,
    line: usize,

    pub fn init(code: [:0]const u8) Lexer {
        return Lexer {
            .str = code,
            .pos = 0,
            .len = code.len,
            .col = 1,
            .line = 1,
        };
    }

    fn read_char(self: *Lexer) u8 {
        var pos: i64 = @intCast(self.pos);
        if (pos - 1 == self.len) return 0;
        const ret = self.str[self.pos];
        self.pos += 1;
        self.col += 1;

        return ret;
    }

    pub fn step_back(self: *Lexer, len: usize) LexerError!void {
        if (self.pos - len < 0) {
            return LexerError.CannotGoBackwards;
        }
        self.pos -= len;
        self.col -= len;
        if (self.str[self.pos] == '\n') {
            self.col = 0;
            self.line -= 1;
        }
    }

    fn skip_blank(self: *Lexer) !void {
        var current: u8 = self.read_char();
        while (current == ' ' or current == '\t' or current == '\n') {
            current = self.read_char();
        }
        if (current == '\n') {
            self.col = 0;
            self.line += 1;
        }

        if (current == 0) {
            return;
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
        self.col = 0;
        self.line += 1;
    }

    fn tokenize_identifier(self: *Lexer) !Token {
        var tok: Token = undefined;
        tok.type = TokenTypes.identifier;
        tok.col = self.col;
        tok.line = self.line;

        const start = self.pos;
        var current: u8 = self.read_char();

        while (std.ascii.isDigit(current) or std.ascii.isAlphabetic(current) or current == '_' or current == '$') {
            current = self.read_char();
        }

        try self.step_back(1);
        tok.text = self.str[start..self.pos];

        if (tok.text.len == 4 and std.mem.eql(u8, "true", tok.text)) {
            tok.type = TokenTypes.bool;
        } else if (tok.text.len == 5 and std.mem.eql(u8, "false", tok.text)) {
            tok.type = TokenTypes.bool;
        }

        return tok;
    }

    fn tokenize_number(self: *Lexer) !Token {
        var tok: Token = undefined;
        tok.type = TokenTypes.int;
        tok.col = self.col;
        tok.line = self.line;

        var is_float: bool = false;
        const start = self.pos;

        var current = self.read_char();

        while (std.ascii.isDigit(current) or current == '.') {
            current = self.read_char();
            if (current == '.') {
                is_float = true;
                continue;
            }
            if (current == '.' and is_float) break;
        }

        try self.step_back(1);
        tok.text = self.str[start..self.pos];

        if (is_float) {
            tok.type = TokenTypes.float;
        }

        return tok;
    }

    fn tokenize_string(self: *Lexer, to_end: u8) !Token {
        var tok: Token = undefined;
        tok.type = TokenTypes.string;
        tok.line = self.line;
        tok.col = self.col;

        const start = self.pos;

        var current = self.read_char();
        while (true) {
            var next: u8 = self.read_char();
            if (current == 0) break;
            if (current == '\\' and next == to_end) {
                current = self.read_char();
                continue;
            }
            try self.step_back(1);
            if (current == to_end) break;
            current = self.read_char();
        }
        tok.text = self.str[start..self.pos];

        return tok;
    }

    pub fn parse_token(self: *Lexer) !Token {
        try self.skip_blank();
        const tok = self.read_char();

        if (tok == 0) {
            return Token{
                .type = TokenTypes.eof,
                .text = "EOF",
                .line = self.line,
                .col = self.col
            };
        }

        switch (tok) {
            '"', '\'' => {
                return try self.tokenize_string(tok);
            },
            ':' => {
                return Token{
                    .text = ":",
                    .type = TokenTypes.colon,
                    .col = self.col,
                    .line = self.line,
                };
            },
            ',' => {
                return Token{
                    .text = ",",
                    .type = TokenTypes.comma,
                    .col = self.col,
                    .line = self.line,
                };
            },
            '[' => {
                return Token{
                    .text = "[",
                    .type = TokenTypes.lsquarebracket,
                    .col = self.col,
                    .line = self.line,
                };
            },
            ']' => {
                return Token{
                    .text = "]",
                    .type = TokenTypes.rsquarebracket,
                    .col = self.col,
                    .line = self.line,
                };
            },
            '{' => {
                return Token{
                    .text = "{",
                    .type = TokenTypes.lsquiglybracket,
                    .col = self.col,
                    .line = self.line,
                };
            },
            '}' => {
                return Token{
                    .text = "}",
                    .type = TokenTypes.rsquiglybracket,
                    .col = self.col,
                    .line = self.line,
                };
            },
            '-' => {
                try self.skip_comment();
                return self.parse_token();
            },
            else => {}
        }

        if (std.ascii.isAlphabetic(tok) or tok == '_') {
            try self.step_back(1);
            return try self.tokenize_identifier();
        } else if (std.ascii.isDigit(tok)) {
            try self.step_back(1);
            return try self.tokenize_number();
        } else {
            return Token{
                .text = "ILL",
                .type = TokenTypes.illegal,
                .col = self.col,
                .line = self.line,
            };
        }
    }
};
