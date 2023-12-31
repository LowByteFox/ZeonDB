const std = @import("std");
const network = @import("networking");
const api = @import("api.zig");

pub fn indexof(buff: []const u8, char: u8) isize {
    for (buff,0..) |c, i| {
        if (c == char) return i;
    }
    return -1;
}

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

    var zeon = api.zeon_connection_init("127.0.0.1", 6748).?;
    defer api.zeon_connection_deinit(zeon);

    if (api.zeon_connection_dead(zeon)) {
        std.debug.print("Unable to contact ZeonDB\n", .{});
        std.os.exit(1);
    }

    std.debug.print("Username: ", .{});
    var username = try getline(allocator);
    std.debug.print("Password: ", .{});
    var password = try getline(allocator);

    if (api.zeon_connection_auth(zeon, username, password)) {
        if (api.zeon_connection_dead(zeon)) {
            std.debug.print("Unable to contact ZeonDB\n", .{});
            std.os.exit(1);
        }
        while (true) {
            std.debug.print("({s}@{s})> ", .{username, "127.0.0.1"});
            var command = try getline(allocator);
            defer allocator.free(command);

            if (command.len >= 4 and std.mem.eql(u8, command[0..4], "exit")) {
                break;
            }

            if (command.len > 1015) {
                const leftover = (command.len - 1015) % 1024;
                const tofill = 1024 - leftover;
                command = try allocator.realloc(command, command.len + tofill);
            }

            var res = api.zeon_connection_execute(zeon, command);
            defer res.deinit();

            if (res.type == .ZEON_ERR) {
                std.debug.print("{s}\n", .{res.data.buffer});
            }

            if (res.type == .ZEON_OK) {
                std.debug.print("{s}\n", .{res.data.buffer});
            }

            if (res.type == .ZEON_DEAD) {
                std.debug.print("Unable to contact ZeonDB\n", .{});
                std.os.exit(1);
            }
        }
    } else {
        std.debug.print("{s}\n", .{zeon.res.data.buffer});
    }
}
