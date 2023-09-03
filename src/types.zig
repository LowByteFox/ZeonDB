const collection = @import("collection.zig");

pub const Types = enum {
    String,
    Int,
    Float,
    Bool,
    Collection,
};

pub const ValueU = union {
    s: []const u8,
    i: i64,
    f: f64,
    b: bool,
    c: collection.Collection
};

pub const Value = struct {
    type: Types,
    value: ValueU
};

