const std = @import("std");
const collection = @import("collection.zig");
const utils = @import("utils.zig");

pub const FormatType = enum {
    ZQL,
    JSON
};

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

pub fn stringifyArray(array: *std.ArrayList(*Value), format: FormatType, allocator: std.mem.Allocator) ![]u8 {
    var str = try utils.strdup("[", allocator);

    for (array.items) |item| {
        var stringified = try stringify(item, format, allocator);
        const old_size = str.len;

        var new_size = str.len + stringified.len;
        if (format == .JSON) {
            new_size += 2;
        } else {
            new_size += 1;
        }
        str = try allocator.realloc(str, new_size);

        utils.copy_over(str, old_size, stringified);

        if (format == .JSON) {
            utils.copy_over(str, new_size - 2, ", ");
        } else {
            str[str.len - 1] = ' ';
        }
    }
    if (format == .JSON) {
        str = try allocator.realloc(str, str.len - 1);
    }
    str[str.len - 1] = ']';

    return str;
}

pub fn stringify(val: *Value, format: FormatType, allocator: std.mem.Allocator) anyerror![]u8 {
    switch (val.*) {
        Value.String => {
            if (utils.includes(val.String, ' ') or format == .JSON) {
                return std.fmt.allocPrint(allocator, "\"{s}\"", .{val.String});
            }
            return utils.strdup(val.String, allocator);
        },
        Value.Int => {
            return std.fmt.allocPrint(allocator, "{d}", .{val.Int});
        },
        Value.Float => {
            return std.fmt.allocPrint(allocator, "{d}", .{val.Float});
        },
        Value.Bool => {
            if (val.Bool) {
                return utils.strdup("true", allocator);
            }
            return utils.strdup("false", allocator);
        },
        Value.Array => {
            return stringifyArray(&val.Array, format, allocator);
        },
        Value.Collection => {
            return val.Collection.stringify(format, allocator);
        }
    }
}

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
