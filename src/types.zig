pub const Types = enum {
    String,
    Int,
    Float,
    Bool
};

pub const ValueU = union {
    s: []const u8,
    i: i64,
    f: f64,
    b: bool
};

pub const Value = struct {
    type: Types,
    value: ValueU
};

