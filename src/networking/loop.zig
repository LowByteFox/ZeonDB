const xev = @import("xev");
const types = @import("../types.zig");
const std = @import("std");
const collection = @import("../collection.zig");
const parser = @import("../zql/parser.zig");
const utils = @import("../utils.zig");
const ctx = @import("../zql/ctx.zig");
const client = @import("client.zig");

pub fn on_accept(self: ?*Server, l: *xev.Loop, _: *xev.Completion, connection: xev.TCP.AcceptError!xev.TCP) xev.CallbackAction {
    var conn = connection catch {
        return .disarm;
    };

    var cl = client.Client.init(self.?.allocator.?.*, self.?, conn) catch {
        return .disarm;
    };

    cl.frame.status = @enumFromInt(0);
    cl.frame.target_length = 0;
    cl.frame.to_buffer(null);
    cl.client.write(l, &cl.completion, .{ .slice = &cl.frame.fixed_buffer }, client.Client, cl, &inform_client);
    cl.client.read(l, &cl.completion, .{ .slice = &cl.frame.fixed_buffer }, client.Client, cl, &get_frame);
    return .disarm;
}

pub fn inform_client(self: ?*client.Client, _: *xev.Loop, _: *xev.Completion, _: xev.TCP, _: xev.WriteBuffer, r: xev.TCP.WriteError!usize) xev.CallbackAction {
    _ = r catch {
        self.?.deinit(self.?.server.allocator.?.*);
    };
    return .disarm;
}

pub fn get_frame(self: ?*client.Client, l: *xev.Loop, c: *xev.Completion, _: xev.TCP, _: xev.ReadBuffer, r: xev.TCP.ReadError!usize) xev.CallbackAction {
    var bytes_read = r catch {
        self.?.deinit(self.?.server.allocator.?.*);
        return .disarm;
    };
    _ = bytes_read;

    self.?.frame.from_buffer();
    switch (self.?.frame.status) {
        .Ok => {},
        .Auth => {
            @panic("Soon enough");
        },
        else => {
            @panic("implementing");
        },
    }
    _ = c;
    _ = l;
    return .disarm;
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
