const std = @import("std");
const trie = @import("trie.zig");
const types = @import("./types.zig");

// A Collection is Trie with improved API and data encapsulation
pub const Collection = struct {
    db: *trie.Trie(types.Value),

    pub fn init(allocator: std.mem.Allocator) !Collection {
        return Collection{
            .db = try trie.Trie(types.Value).init(allocator)
        };
    }

    pub fn deinit(self: *Collection, allocator: std.mem.Allocator) void {
        self.db.deinit(allocator);
        allocator.destroy(self.db);
    }

    pub fn add(self: *Collection, key: []const u8, dataType: types.Types, value: types.ValueU, allocator: std.mem.Allocator) !void {
        try self.db.add(key, types.Value{
            .type = dataType,
            .value = value
        }, allocator);
    }

    pub fn get(self: *const Collection, key: []const u8) ?types.Value {
        return self.db.get(key);
    }
};

pub const Types = types.Types;
pub const Value = types.ValueU;
