const std = @import("std");
const xev = @import("xev");
const server = @import("loop.zig");
const comm = @import("frame.zig");
const Server = server.Server;

pub const Client = struct {
    server: *Server,
    buffer: [:0]u8,
    output: []u8,
    transfered: u64,
    client: xev.TCP,
    completion: xev.Completion,
    frame: comm.ZeonFrame,

    pub fn init(allocator: std.mem.Allocator, serv: *Server, connection: xev.TCP) !*Client {
        var client: *Client = try allocator.create(Client);
        client.server = serv;
        client.client = connection;
        client.completion = undefined;
        client.buffer = try allocator.allocSentinel(u8, 0, 0);
        client.output = try allocator.alloc(u8, 0);
        client.transfered = 0;
        client.frame = undefined;

        return client;
    }

    pub fn deinit(self: *@This(), allocator: std.mem.Allocator) void {
        allocator.free(self.buffer);
        allocator.free(self.output);
        allocator.destroy(self);
    }
};
