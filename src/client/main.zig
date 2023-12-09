const std = @import("std");
const network = @import("networking");
const api = @import("api.zig");

pub fn copy_over(buff: []u8, start: usize, str: []const u8) void {
    for (0..str.len) |i| {
        buff[i + start] = str[i];
    }
}

fn getline(allocator: std.mem.Allocator) ![]u8 {
    const stdin = std.io.getStdIn().reader();

    var buff: [1024]u8 = undefined;
    var data: ?[]u8 = null;
    var bytes_read: usize = 1;

    while (bytes_read > 0) {
        bytes_read = (try stdin.readUntilDelimiter(&buff, '\n')).len;
        if (data == null) {
            data = try allocator.alloc(u8, bytes_read);
            @memcpy(data.?, buff[0..bytes_read]);
            break;
        }
        data = try allocator.realloc(data.?, data.?.len + bytes_read);
        copy_over(data.?, data.?.len - bytes_read, buff[0..bytes_read]);
    }

    return data.?;
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    defer std.debug.assert(gpa.deinit() == .ok);

    var zeon = api.zeon_connection_init("127.0.0.1", 6748).?;
    defer api.zeon_connection_deinit(zeon);

    if (api.zeon_connection_auth(zeon, "theo", "paris")) {
        var end = false;
        while (true) {
            std.debug.print("({s}@{s})> ", .{"theo", "127.0.0.1"});
            var command = try getline(allocator);
            defer allocator.free(command);

            end = std.mem.eql(u8, command[0..4], "quit");
            if (end) break;

            if (command.len > 1015) {
                const leftover = (command.len - 1015) % 1024;
                const tofill = 1024 - leftover;
                command = try allocator.realloc(command, command.len + tofill);
            }

            api.zeon_connection_execute(zeon, command);
        }
    }
}
