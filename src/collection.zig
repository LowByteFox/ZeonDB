const std = @import("std");
const trie = @import("./trie.zig");
const types = @import("./types.zig");
const utils = @import("./utils.zig");
const accounts = @import("accounts.zig");

// A Collection is Trie with improved API and data encapsulation
pub const Collection = struct {
    db: *trie.Trie(*types.Value),
    keys: std.ArrayList([]const u8),
    perms: std.StringHashMap(accounts.Permission),

    pub fn init(allocator: std.mem.Allocator) !Collection {
        return Collection{
            .db = try trie.Trie(*types.Value).init(allocator),
            .keys = std.ArrayList([]const u8).init(allocator),
            .perms = std.StringHashMap(accounts.Permission).init(allocator)
        };
    }

    pub fn deinit(self: *Collection, allocator: std.mem.Allocator) void {
        self.db.deinit(allocator);
        for (self.keys.items) |key| {
            allocator.free(key);
        }
        self.keys.deinit();
        allocator.destroy(self.db);
        self.perms.deinit();
    }

    pub fn assign_perm(self: *Collection, username: []const u8, key: []const u8, perm: accounts.Permission, allocator: std.mem.Allocator) !void {
        var buffer = try std.fmt.allocPrint(allocator, "{s}:{s}", .{username, key});
        try self.perms.put(buffer, perm);
    }

    pub fn get_perm(self: *Collection, username: []const u8, key: []const u8, allocator: std.mem.Allocator) !?accounts.Permission {
        var buffer = try std.fmt.allocPrint(allocator, "{s}:{s}", .{username, key});
        defer allocator.free(buffer);

        const perm = self.perms.getPtr(buffer);
        if (perm) |p| {
            return p.*;
        }
        return null;
    }

    pub fn add(self: *Collection, key: []const u8, value: *Value, allocator: std.mem.Allocator) !void {
        try self.db.add(key, value, allocator);
        var add_key: bool = true;

        for (self.keys.items) |item| {
            if (item.len == key.len and std.mem.eql(u8, item, key)) {
                add_key = false;
                break;
            }
        }
        if (add_key) {
            try self.keys.append(try utils.strdup(key, allocator));
        }
    }

    pub fn get(self: *const Collection, key: []const u8) ?*types.Value {
        return self.db.get(key);
    }

    pub fn stringify(self: *Collection, format: types.FormatType, allocator: std.mem.Allocator) ![]u8 {
        var str = try utils.strdup("{", allocator);

        for (self.keys.items) |key| {
            var key_str: ?[]u8 = null;
            if (utils.includes(key, ' ') or format == .JSON) {
                if (format == .JSON) {
                    key_str = try std.fmt.allocPrint(allocator, "\"{s}\":", .{key});
                } else {
                    key_str = try std.fmt.allocPrint(allocator, "\"{s}\"", .{key});
                }
            } else {
                key_str = try utils.strdup(key, allocator);
            }
            var old_len = str.len;
            str = try allocator.realloc(str, str.len + key_str.?.len + 1);
            str[str.len - 1] = ' ';
            utils.copy_over(str, old_len, key_str.?);
            allocator.free(key_str.?);

            var value = try types.stringify(self.get(key).?, format, allocator);
            old_len = str.len;

            str = try allocator.realloc(str, str.len + value.len + 2);
            utils.copy_over(str, old_len, value);
            allocator.free(value);
            if (format == .JSON) {
                utils.copy_over(str, str.len - 2, ", ");
            } else {
                str[str.len - 1] = ' ';
            }
        }
        if (str.len > 1 and format == .JSON) {
            str = try allocator.realloc(str, str.len - 1);
        }
        if (str.len == 1) {
            str = try allocator.realloc(str, str.len + 1);
        }
        str[str.len - 1] = '}';

        return str;
    }
};

pub const Types = types.Types;
pub const Value = types.Value;
