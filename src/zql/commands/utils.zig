const std = @import("std");
const types = @import("../../types.zig");

pub fn allocate_value(val: types.Value, allocator: std.mem.Allocator) !*types.Value {
    var v = try allocator.create(types.Value);
    v.* = val;
    return v;
}
