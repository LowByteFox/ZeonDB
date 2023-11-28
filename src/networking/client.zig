const std = @import("std");
const xev = @import("xev");
const server = @import("loop.zig");
const comm = @import("frame.zig");
const Server = server.Server;

pub fn dummy_send(_: ?*void, _: *xev.Loop, _: *xev.Completion, _: xev.TCP, _: xev.WriteBuffer, r: xev.TCP.WriteError!usize) xev.CallbackAction {
    _ = r catch unreachable;
    return .disarm;
}

pub const Client = struct {
    server: *Server,
    buffer: [:0]u8,
    output: []u8,
    transfered: u64,
    client: xev.TCP,
    completion: xev.Completion,
    frame: comm.ZeonFrame,
    user: []u8,

    pub fn init(allocator: std.mem.Allocator, serv: *Server, connection: xev.TCP) !*Client {
        var client: *Client = try allocator.create(Client);
        client.server = serv;
        client.client = connection;
        client.completion = undefined;
        client.buffer = try allocator.allocSentinel(u8, 0, 0);
        client.output = try allocator.alloc(u8, 0);
        client.user = try allocator.alloc(u8, 0);
        client.transfered = 0;
        client.frame = undefined;

        return client;
    }

    pub fn send_message(self: *@This(), loop: *xev.Loop) void {
        self.client.write(loop, &self.completion, .{ .slice = &self.frame.fixed_buffer }, void, null, &dummy_send);
    }

    pub fn login(self: *@This(), username: []u8) !void {
        self.user = try self.server.allocator.?.realloc(self.user, username.len);
        @memcpy(self.user, username);
    }

    pub fn deinit(self: *@This(), allocator: std.mem.Allocator) void {
        allocator.free(self.buffer);
        allocator.free(self.output);
        allocator.free(self.user);
        allocator.destroy(self);
    }
};
