const std = @import("std");
const types = @import("types.zig");

pub fn Trie(comptime T: type) type {
    return struct {
        data: ?T,
        childs: [95]?*Trie(T),

        pub fn init(allocator: std.mem.Allocator) !*Trie(T) {
            var trie = try allocator.create(Trie(T));
            trie.childs = .{null} ** 95;
            trie.data = null;
            return trie;
        }

        pub fn deinit(self: *Trie(T), allocator: std.mem.Allocator) void {
            if (T == types.Value) {
                if (self.data != null) {
                    switch (self.data.?.t) {
                        types.Types.Collection => {
                            self.data.?.v.c.deinit(allocator);
                        },

                        types.Types.Array => {
                            self.data.?.v.a.deinit();
                        },

                        else => {}
                    }
                }
            }

            for (self.childs) |child| {
                if (child) |chld| {
                    chld.deinit(allocator);
                    allocator.destroy(chld);
                }
            }
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
                    return null;
                }
            }

            return node.data;
        }
    };
}
