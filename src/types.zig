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

pub const Value = union(Types) {
    Array: std.ArrayList(*Value),
    String: []const u8,
    Int: i64,
    Float: f64,
    Bool: bool,
    Collection: collection.Collection
};
