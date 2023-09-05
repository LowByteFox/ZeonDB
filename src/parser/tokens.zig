pub const TokenTypes = enum {
    eof,
    illegal,
    identifier,
    string,
    int,
    float,
    bool,
    dot,
    lsquarebracket,
    rsquarebracket,
    lsquiglybracket,
    rsquiglybracket
};

pub const Token = struct {
    t: TokenTypes,
    s: []u8,
};
