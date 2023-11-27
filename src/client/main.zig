const std = @import("std");
const xev = @import("xev");
const frame = @import("frame.zig");

pub fn copy_over(buff: []u8, start: usize, str: []const u8) void {
    for (0..str.len) |i| {
        buff[i + start] = str[i];
    }
}

pub fn strdup(buff: []const u8, allocator: std.mem.Allocator) ![]u8 {
    var target = try allocator.alloc(u8, buff.len);
    @memcpy(target, buff);
    return target;
}

var last_in: []u8 = undefined;

const Zeon = struct {
    allocator: *const std.mem.Allocator,
    frame: frame.ZeonFrame,
    buffer: []u8,
    db: xev.TCP,
    completion: xev.Completion,
    transfered: u64,
    authentificated: bool,

    pub fn init(allocator: *const std.mem.Allocator, connection: xev.TCP) !*Zeon {
        var zeon = try allocator.create(Zeon);
        zeon.allocator = allocator;
        zeon.db = connection;
        zeon.completion = undefined;
        zeon.frame = undefined;
        zeon.buffer = try allocator.alloc(u8, 0);
        zeon.transfered = 0;
        zeon.authentificated = false;
        return zeon;
    }

    pub fn deinit(self: *Zeon) void {
        self.allocator.free(self.buffer);
        self.allocator.destroy(self);
    }
};

fn getcol(begin: usize, str: []const u8) i32 {
    var start: usize = 0;
    var end: usize = 0;
    for (begin..str.len) |i| {
        if (str[i] == ':') {
            start = i + 1;
            end = i + 1;
            while (std.ascii.isDigit(str[end])) { 
                end += 1;
            }
            break;
        }
    }

    return std.fmt.parseInt(i8, str[start..end], 10) catch -1;
}

fn getin(allocator: std.mem.Allocator) ![]u8 {
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
    
    var loop = try xev.Loop.init(.{});
    defer loop.deinit();

    var address = try std.net.Address.parseIp4("127.0.0.1", 6748);

    const client = try xev.TCP.init(address);

    var compl: xev.Completion = undefined;

    client.connect(&loop, &compl, address, std.mem.Allocator, @constCast(&allocator), &on_connect);

    try loop.run(.until_done);
}

pub fn sha256(pass: []const u8, out: *[32]u8) void {
    var hash = std.crypto.hash.sha2.Sha256.init(.{});
    hash.update(pass);
    hash.final(out[0..32]);
}

fn on_connect(allocator: ?*std.mem.Allocator, l: *xev.Loop, _: *xev.Completion, connection: xev.TCP, res: xev.TCP.ConnectError!void) xev.CallbackAction {
    _ = res catch {
        return .disarm;
    };

    var zeon = Zeon.init(allocator.?, connection) catch {
        return .disarm;
    };

    zeon.db.read(l, &zeon.completion, .{ .slice = &zeon.frame.fixed_buffer }, Zeon, zeon, &get_info);
    return .disarm;
}

fn get_info(self: ?*Zeon, l: *xev.Loop, c: *xev.Completion, _: xev.TCP, _: xev.ReadBuffer, r: xev.TCP.ReadError!usize) xev.CallbackAction {
    var bytes_read = r catch {
        self.?.deinit();
        return .disarm;
    };
    _ = bytes_read;

    self.?.frame.from_buffer();
    switch (self.?.frame.status) {
        .Ok => {
            if (!self.?.authentificated) {
                return auth(self, l);
            }
        },
        else => {
            @panic("Not implemented");
        },
    }
    _ = c;
    return .disarm;
}

fn auth(self: ?*Zeon, loop: *xev.Loop) xev.CallbackAction {
    std.debug.print("Enter username: ", .{});

    var username = getin(self.?.allocator.*) catch {
        self.?.deinit();
        return .disarm;
    };

    std.debug.print("Enter password: ", .{});
    var pass = getin(self.?.allocator.*) catch {
        self.?.deinit();
        return .disarm;
    };

    var hash: [32]u8 = undefined;
    sha256(pass, &hash);
    var buffer: [1015]u8 = undefined;
    var printed = std.fmt.bufPrint(&buffer, "{s} {s}", .{username, hash}) catch {
        self.?.allocator.free(username);
        self.?.allocator.free(pass);
        self.?.deinit();
        return .disarm;
    };
    self.?.allocator.free(username);
    self.?.allocator.free(pass);

    var fram: frame.ZeonFrame = undefined;
    fram.status = .Auth;
    fram.to_buffer(printed.len);
    fram.write_buffer(buffer[0..1015]);

    self.?.frame = fram;
    self.?.db.write(loop, &self.?.completion, .{ .slice = &self.?.frame.fixed_buffer }, Zeon, self, &auth_write);
    return .disarm;
}

fn auth_res(self: ?*Zeon, l: *xev.Loop, c: *xev.Completion, _: xev.TCP, _: xev.ReadBuffer, r: xev.TCP.ReadError!usize) xev.CallbackAction {
    var bytes_read = r catch {
        self.?.deinit();
        return .disarm;
    };
    _ = bytes_read;

    self.?.frame.from_buffer();
    switch (self.?.frame.status) {
        .Ok => {
            self.?.authentificated = true;
        },
        .Error => {
            @panic("Buffer reading needs to be implemented");
        },
        else => {
            @panic("Not implemented");
        },
    }
    _ = c;
    _ = l;
    return .disarm;
}

pub fn auth_write(self: ?*Zeon,  l: *xev.Loop, _: *xev.Completion, _: xev.TCP, _: xev.WriteBuffer, res: xev.TCP.WriteError!usize) xev.CallbackAction {
    _ = res catch {
        self.?.deinit();
        return .disarm;
    };

    self.?.db.read(l, &self.?.completion, .{ .slice = &self.?.frame.fixed_buffer }, Zeon, self, &auth_res);
    return .disarm;
}
