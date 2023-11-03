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

pub fn disposeArray(array: *std.ArrayList(*Value), allocator: std.mem.Allocator) void {
    for (array.items) |i| {
        dispose(i, allocator);
    }
}

pub fn dispose(val: *Value, allocator: std.mem.Allocator) void {
    switch (val.*) {
        Value.String => {
            allocator.free(val.String);
        },
        Value.Array => {
            disposeArray(&val.Array, allocator);
            val.Array.deinit();
        },
        Value.Collection => {
            val.Collection.deinit(allocator);
        },
        else => {}
    }
    allocator.destroy(val);
}
