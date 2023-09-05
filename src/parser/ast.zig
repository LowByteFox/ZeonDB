const std = @import("std");
const toks = @import("./tokens.zig");

// Names
// Command
// Key
// Value
// Collection
// Array
pub const Node = struct {
    name: []const u8,
    children: ?std.ArrayList(Node),
    tok: ?toks.Token,

    pub fn init(name: []const u8) Node {
        return Node{
            .name = name,
            .children = null,
            .tok = null
        };
    }

    pub fn setToken(self: *Node, tok: toks.Token, allocator: std.mem.Allocator) !void {
        self.tok = toks.Token{
            .t = tok.t,
            .s = try allocator.alloc(u8, tok.s.len)
        };

        @memcpy(self.tok.?.s, tok.s);
    }

    pub fn add(self: *Node, child: Node, allocator: ?std.mem.Allocator) void {
        if (self.children == null) {
            if (allocator != null) { unreachable; }
            self.children = std.ArrayList(Node).init(allocator);
        }

        self.children.?.append(child);
    }
};
