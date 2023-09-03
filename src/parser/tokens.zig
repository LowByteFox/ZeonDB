pub const TokenTypes = enum {
    eof,
    illegal,
    identifier,
    string,
    int,
    float,
    bool,
    dot,
    lsquarebrakcet,
    rsquarebracket,
    lsquiglybracket,
    rsquiglybracket
};

pub const Token = struct {
    t: TokenTypes,
    s: []const u8,
};
