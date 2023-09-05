const std = @import("std");
const parser = @import("./parser/parser.zig");
const collection = @import("./collection.zig");

var instance_count: i32 = 0;

pub const Executor = struct {
    parser: parser.Parser,
    db: *collection.Collection,

    pub fn init(db: ?*collection.Collection, code: []const u8) ?Executor {
        if (instance_count == 0) {
            if (db == null) {
                // FIX: Must be fixed
                unreachable;
            }

            instance_count += 1;
            return Executor{
                .parser = parser.Parser.init(code),
                .db = db.?
            };
        }

        return null;
    }

    pub fn exec(self: *Executor, allocator: std.mem.Allocator) !void {
        var arr = try self.parser.parse(allocator);

        for (0..arr.items.len) |i| {
            std.debug.print("{s}\n", .{arr.items[i].tok.?.s});
            allocator.free(arr.items[i].tok.?.s);
        }

        arr.deinit();
    }
};
