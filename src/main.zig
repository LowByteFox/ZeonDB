const std = @import("std");

fn Trie(comptime T: type) type {
    return struct {
        allocator: ?std.mem.Allocator,
        data: ?T,
        childs: []?*Trie(T),

        pub fn init(allocator: std.mem.Allocator) !*Trie(T) {
            var trie = try allocator.create(Trie(T));
            trie.allocator = allocator;
            trie.childs = try allocator.alloc(?*Trie(T), 95);
            @memset(trie.childs, null);
            trie.data = null;
            return trie;
        }

        pub fn deinit(self: *Trie(T), allocator: ?std.mem.Allocator) void {
            for (self.childs) |child| {
                if (child) |chld| {
                    if (allocator) |alloc| {
                        chld.deinit(alloc);
                        alloc.destroy(chld);
                    } else {
                        chld.deinit(self.allocator);
                        self.allocator.?.destroy(chld);
                    }
                }
            }
            if (allocator) |alloc| {
                alloc.free(self.childs);
            } else {
                self.allocator.?.free(self.childs);
            }
        }

        pub fn add(self: *Trie(T), key: []const u8, value: T) !void {
            var node = self;
            for (key) |letter| {
                if (node.childs[letter - 32]) |n| {
                    node = n;
                } else {
                    node.childs[letter - 32] = try Trie(T).init(self.allocator.?);
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

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer std.debug.assert(gpa.deinit() == .ok);

    const allocator = gpa.allocator();

    var trie = try Trie(i32).init(allocator);
    defer allocator.destroy(trie);
    defer trie.deinit(null);

    try trie.add("sup", 77);

    if (trie.get("sup")) |val| {
        std.debug.print("{}\n", .{val});
    }
}
