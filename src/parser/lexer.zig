const std = @import("std");
const tkns = @import("tokens.zig");
const tokens = tkns.TokenTypes;
const token = tkns.Token;

fn allocateStr(string: []const u8, allocator: std.mem.Allocator) ![]u8 {
    var alloc = try allocator.alloc(u8, string.len);
    @memcpy(alloc, string);

    return alloc;
}

pub const Lexer = struct {
    str: []const u8,
    pos: i32,
    len: usize,

    pub fn init(string: []const u8) Lexer {
        return Lexer{
            .str = string,
            .pos = 0,
            .len = string.len
        };
    }

    pub fn read(self: *Lexer) u8 {
        if (self.pos == self.len) return 0;
        const ret = self.str[@intCast(self.pos)];
        self.pos += 1;
        return ret;
    }

    pub fn back(self: *Lexer) void {
        self.pos -= 1;
    }

    pub fn skip_blank(self: *Lexer) void {
        var current = self.read();
        if (current == 0) return;

        while (current == ' ' or current == '\t') {
            current = self.read();
        }
        self.back();
    }

    pub fn consume_identifier(self: *Lexer, allocator: std.mem.Allocator) !token {
        var str: []u8 = try allocator.alloc(u8, 1);

        var current = self.read();

        while (std.ascii.isDigit(current) or std.ascii.isAlphabetic(current) or current == '_') {
            str[str.len - 1] = current;
            str = try allocator.realloc(str, str.len + 1);
            current = self.read();
        }
        str = try allocator.realloc(str, str.len - 1);

        self.back();

        if (std.mem.eql(u8, "true", str)) {
            return token{
                .t = tokens.bool,
                .s = str
            };
        } else if (str.len >= 5) {
            if (std.mem.eql(u8, "false", str)) {
                return token{
                    .t = tokens.bool,
                    .s = str
                };
            }
        }

        return token{
            .t = tokens.identifier,
            .s = str
        };
    }

    pub fn consume_string(self: *Lexer, delim: u8, allocator: std.mem.Allocator) !token {
        var str: []u8 = try allocator.alloc(u8, 1);

        str[str.len - 1] = delim;
        str = try allocator.realloc(str, str.len + 1);

        while (true) {
            var current = self.read();
            var next = self.read();
            if (current == 0) break;
            if (current == '\\' and next == delim) {
                str[str.len - 1] = current;
                str = try allocator.realloc(str, str.len + 1);
                str[str.len - 1] = next;
                str = try allocator.realloc(str, str.len + 1);
                continue;
            }
            self.back();
            str[str.len - 1] = current;
            str = try allocator.realloc(str, str.len + 1);
            if (current == delim) break;
        }
        str = try allocator.realloc(str, str.len - 1);

        return token{
            .t = tokens.string,
            .s = str
        };
    }

    pub fn consume_number(self: *Lexer, allocator: std.mem.Allocator) !token {
        var str: [] u8 = try allocator.alloc(u8, 1);
        var is_float: bool = false;

        var current = self.read();

        while (std.ascii.isDigit(current) or current == '.') {
            str[str.len - 1] = current;
            str = try allocator.realloc(str, str.len + 1);
            current = self.read();
            if (current == '.') {
                is_float = true;
                continue;
            }
            if (current == '.' and is_float) break;
        }
        str = try allocator.realloc(str, str.len - 1);

        self.back();

        return token{
            .t = if (is_float) tokens.float else tokens.int,
            .s = str
        };
    }

    pub fn generate_token(self: *Lexer, allocator: std.mem.Allocator) !token {
        self.skip_blank();
        const tok = self.read();

        if (tok == 0 or self.len == self.pos) {
            return token{
                .s = try allocator.alloc(u8, 1),
                .t = tokens.eof,
            };
        }

        switch (tok) {
            '"', '\'' => {
                return try self.consume_string(tok, allocator);
            },
            '.' => {
                return token{
                    .s = try allocateStr(".", allocator),
                    .t = tokens.dot
                };
            },
            else => {}
        }

        if (std.ascii.isAlphabetic(tok) or tok == '_') {
            self.back();
            return try self.consume_identifier(allocator);
        } else if (std.ascii.isDigit(tok)) {
            self.back();
            return try self.consume_number(allocator);
        } else {
            return token{
                .s = try allocateStr("ILL", allocator),
                .t = tokens.illegal
            };
        }
    }
};
