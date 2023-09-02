const std = @import("std");

pub fn Trie(comptime T: type) type {
    return struct {
        data: ?T,
        childs: []?*Trie(T),

        pub fn init(allocator: std.mem.Allocator) !*Trie(T) {
            var trie = try allocator.create(Trie(T));
            trie.childs = try allocator.alloc(?*Trie(T), 95);
            @memset(trie.childs, null);
            trie.data = null;
            return trie;
        }

        pub fn deinit(self: *Trie(T), allocator: std.mem.Allocator) void {
            for (self.childs) |child| {
                if (child) |chld| {
                    chld.deinit(allocator);
                    allocator.destroy(chld);
                }
            }
            allocator.free(self.childs);
        }

        pub fn add(self: *Trie(T), key: []const u8, value: T, allocator: std.mem.Allocator) !void {
            var node = self;
            for (key) |letter| {
                if (node.childs[letter - 32]) |n| {
                    node = n;
                } else {
                    node.childs[letter - 32] = try Trie(T).init(allocator);
                    node = node.childs[letter - 32].?;
                }
            }

            node.data = value;
        }

        pub fn get(self: *Trie(T), key: []const u8) ?T {
            var node = self;
            for (key) |letter| {
                if (node.childs[letter - 32]) |n| {
                    node = n;
                } else {
                    return undefined;
                }
            }

            return node.data;
        }
    };
}
