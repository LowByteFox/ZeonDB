const std = @import("std");
const trie = @import("./trie.zig");
const types = @import("./types.zig");
const exec = @import("./executor.zig");

// A Collection is Trie with improved API and data encapsulation
pub const Collection = struct {
    db: *trie.Trie(types.Value),
    executor: ?exec.Executor,

    pub fn init(allocator: std.mem.Allocator) !Collection {
        return Collection{
            .db = try trie.Trie(types.Value).init(allocator),
            .executor = null
        };
    }

    pub fn prepare_executor(self: *Collection, code: []const u8) void {
        var e = exec.Executor.init(self, code);
        if (e != null) {
            self.executor = e;
        }
    }

    pub fn deinit(self: *Collection, allocator: std.mem.Allocator) void {
        self.db.deinit(allocator);
        allocator.destroy(self.db);
    }

    pub fn add(self: *Collection, key: []const u8, value: Value, allocator: std.mem.Allocator) !void {
        try self.db.add(key, value, allocator);
    }

    pub fn get(self: *const Collection, key: []const u8) ?types.Value {
        return self.db.get(key);
    }
};

pub const Types = types.Types;
pub const Value = types.Value;
