const std = @import("std");
const collection = @import("collection.zig");

pub const Types = enum {
    Array,
    String,
    Int,
    Float,
    Bool,
    Collection,
};

pub const ValueU = union {
    a: std.ArrayList(Value),
    s: []const u8,
    i: i64,
    f: f64,
    b: bool,
    c: collection.Collection
};

pub const Value = struct {
    t: Types,
    v: ValueU
};
