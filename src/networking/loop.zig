const xev = @import("xev");
const types = @import("../types.zig");
const std = @import("std");
const collection = @import("../collection.zig");
const parser = @import("../zql/parser.zig");

pub const Client = struct {
    server: *Server,
    tmpbuff: [1024]u8,
    buffer: ?[:0]u8,
    outbuff: ?[]u8,
    written: usize,
    client: xev.TCP,
    completion: xev.Completion,
};

pub fn on_accept(self: ?*Server, l: *xev.Loop, _: *xev.Completion, connection: xev.TCP.AcceptError!xev.TCP) xev.CallbackAction {
    var client = self.?.allocator.?.create(Client) catch {
        return .disarm;
    };
    client.server = self.?;
    client.client = connection catch {
        return .disarm;
    };
    client.completion = undefined;
    client.tmpbuff = undefined;
    client.buffer = null;
    client.outbuff = null;
    client.written = 0;

    client.client.read(l, &client.completion, .{ .slice = &client.tmpbuff }, Client, client, &on_read);

    return .rearm;
}

pub fn on_read(self: ?*Client, l: *xev.Loop, c: *xev.Completion, _: xev.TCP, _: xev.ReadBuffer, r: xev.TCP.ReadError!usize) xev.CallbackAction {
    var bytes_read = r catch {
        bozo_left(self.?);
        return .disarm;
    };

    const allocator = self.?.server.allocator.?;

    if (self.?.buffer == null) {
        var i: usize = 0;
        for (self.?.tmpbuff) |ch| {
            if (!std.ascii.isDigit(ch)) {
                break;
            }
            i += 1;
        }

        if (i == 0) {
            return .rearm;
        }

        var len = std.fmt.parseInt(usize, self.?.tmpbuff[0..i], 10) catch {
            bozo_left(self.?);
            return .disarm;
        };

        self.?.buffer = allocator.allocSentinel(u8, len, 0) catch {
            bozo_left(self.?);
            return .disarm;
        };

        @memset(self.?.buffer.?, 0);
        @memcpy(self.?.buffer.?[0..(bytes_read - i)], self.?.tmpbuff[i..bytes_read]);

        self.?.written = bytes_read - i;
    } else {
        if (bytes_read > self.?.buffer.?.len - self.?.written) {
            bytes_read = self.?.buffer.?.len - self.?.written;
        }
        @memcpy(self.?.buffer.?[self.?.written..(self.?.written + bytes_read)], self.?.tmpbuff[0..bytes_read]);
        self.?.written += bytes_read;
    }

    if (self.?.written >= self.?.buffer.?.len) {
        var out = execute(self.?) catch unreachable;
        if (out) |o| {
            var str = types.stringify(o, types.FormatType.JSON, allocator.*) catch unreachable;
            allocator.free(self.?.buffer.?);
            self.?.outbuff = str;
            self.?.client.write(l, c, .{ .slice = self.?.outbuff.? }, Client, self.?, &on_write);
        } else {
            bozo_left(self.?);
        }
        return .disarm;
    }

    return .rearm;
}

pub fn on_write(self: ?*Client, l: *xev.Loop, c: *xev.Completion, _: xev.TCP, _: xev.WriteBuffer, r: xev.TCP.WriteError!usize) xev.CallbackAction {
    _ = r catch {
        bozo_left(self.?);
        return .disarm;
    };

    const allocator = self.?.server.allocator.?;
    allocator.free(self.?.outbuff.?);
    self.?.buffer = null;
    self.?.client.read(l, c, .{ .slice = &self.?.tmpbuff }, Client, self.?, &on_read);
    return .disarm;
}

pub fn execute(client: *Client) !?*types.Value {
    const allocator = client.server.allocator.?;
    var parse = parser.Parser.init(client.server.db.?, client.buffer.?);
    var args = try parse.parse(allocator.*);
    var shared_buffer: ?*types.Value = null;

    for (args.items) |*ctx| {
        try ctx.execute(shared_buffer, allocator.*);
        shared_buffer = ctx.buffer;
        ctx.deinit(allocator.*);
    }

    args.deinit();
    return shared_buffer;
}

pub fn bozo_left(bozo: *Client) void {
    if (bozo.buffer != null) {
        bozo.server.allocator.?.free(bozo.buffer.?);
    }
    bozo.server.allocator.?.destroy(bozo);
}

pub const Server = struct {
    loop: xev.Loop,
    socket: xev.TCP,
    address: std.net.Address,
    completion: xev.Completion,
    port: u16,
    allocator: ?*const std.mem.Allocator,
    db: ?*collection.Collection,

    pub fn init(port: u16) !Server {
        var address = try std.net.Address.parseIp4("127.0.0.1", port);

        return Server {
            .loop = try xev.Loop.init(.{}),
            .socket = try xev.TCP.init(address),
            .address = address,
            .completion = undefined,
            .port = port,
            .allocator = null,
            .db = null
        };
    }

    pub fn run(self: *@This(), db: *collection.Collection, allocator: *const std.mem.Allocator) !void {
        try self.socket.bind(self.address);
        try self.socket.listen(1);

        self.allocator = allocator;
        self.db = db;

        self.socket.accept(&self.loop, &self.completion, @This(), self, &on_accept);

        std.debug.print("Started serving at {any}!\n", .{self.address});
        try self.loop.run(.until_done);
    }

    pub fn deinit(self: *@This()) void {
        self.loop.deinit();
    }
};
