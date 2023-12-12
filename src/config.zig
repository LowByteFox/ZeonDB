const std = @import("std");
const toml = @import("ztoml");
const utils = @import("utils.zig");

const default_config = \\format = "JSON"
                       \\
                       \\[persistence]
                       \\enable = false
                       \\
                       \\[branch]
                       \\default = "main"
                       \\merge_mode = "overwrite"
                       \\
                       \\[accounts]
                       \\default = "guest"
                       \\[accounts.password]
                       \\min_length = 8
                       \\max_length = 32
                       \\
                       \\[communication]
                       \\max_connections = 1000
                       \\[communication.ip]
                       \\enable = true
                       \\port = 6748
                       ;

pub const Config = struct {
    format: []const u8, // ZQL | JSON
    persistence: ?struct {
        enable: bool,
        compression: ?[]const u8, // gzip | xz | lzma | zstd
        bundle: ?bool, // combine persisted data into single archive ideal for backups and migration
        filename: ?[]const u8, // name of the archive ( prefix if not bundle)
    },
    branch: ?struct {
        default: ?[]const u8, // name of default "branch"
        merge_mode: ?[]const u8, // no_overwrite | overwrite | swap
    },
    accounts: ?struct {
        default: ?[]const u8, // default user
        password: ?struct {
            min_length: u32,
            max_length: u32,
        },
    },
    communication: ?struct {
        max_connections: usize,
        ip: ?struct {
            enable: bool,
            port: ?u16
        }
    },
};

fn read_file(file: std.fs.File, allocator: std.mem.Allocator) !?[]u8 {
    var buff: [1024]u8 = undefined;
    var data: ?[]u8 = null;
    var bytes_read: usize = 1;

    while (bytes_read > 0) {
        bytes_read = try file.readAll(&buff);
        if (data == null) {
            data = try allocator.alloc(u8, bytes_read);
            @memcpy(data.?, buff[0..bytes_read]);
            continue;
        }

        data = try allocator.realloc(data.?, data.?.len + bytes_read);
        utils.copy_over(data.?, data.?.len - bytes_read, buff[0..bytes_read]);
    }

    return data;
}

pub fn load_config(allocator: std.mem.Allocator) !toml.Parsed(Config) {
    var local_config_file: ?std.fs.File = std.fs.cwd().openFile("zeondb.toml", .{}) catch null;

    var global_config_file: ?std.fs.File = std.fs.openFileAbsolute("/etc/zeondb.toml", .{}) catch null;

    var parser = toml.Parser(Config).init(allocator);
    defer parser.deinit();

    if (local_config_file) |file| {
        var buf = try read_file(file, allocator);
        if (buf) |b| {
            defer allocator.free(b);
            return try parser.parseString(b);
        }
    }

    if (global_config_file) |file| {
        var buf = try read_file(file, allocator);
        if (buf) |b| {
            defer allocator.free(b);
            return try parser.parseString(b);
        }
    }

    return try parser.parseString(default_config);
}
