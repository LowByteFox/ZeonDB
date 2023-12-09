const std = @import("std");
const uv = @import("uv.zig");
const server = @import("loop.zig");
const comm = @import("frame.zig");
const Server = server.Server;

fn send_msg(req: [*c]uv.uv_write_t, status: i32) callconv(.C) void {
    if (status < 0) {
        std.debug.print("Could not inform client! {s}\n", .{uv.uv_strerror(status)});
        return;
    }

    var client = server.extract_data(Client, @ptrCast(req));
    var r: *uv.uv_write_t = @ptrCast(req);
    client.server.allocator.?.destroy(r);
}

pub const Client = struct {
    server: *Server,
    buffer: [*c]u8,
    read: usize,
    output: []u8,
    client: [*c]uv.uv_tcp_t,
    frame: comm.ZeonFrame,
    user: []u8,
    uvbuf: uv.uv_buf_t,

    pub fn init(allocator: std.mem.Allocator, serv: *Server, connection: [*c]uv.uv_tcp_t) !*Client {
        var client: *Client = try allocator.create(Client);
        client.server = serv;
        client.client = connection;
        client.buffer = null;
        client.read = 0;
        client.output = try allocator.alloc(u8, 0);
        client.user = try allocator.alloc(u8, 0);
        client.frame = undefined;
        client.uvbuf = undefined;

        return client;
    }

    pub fn login(self: *@This(), username: []u8) !void {
        self.user = try self.server.allocator.?.realloc(self.user, username.len);
        @memcpy(self.user, username);
    }

    pub fn deinit(self: *@This(), allocator: std.mem.Allocator) void {
        std.c.free(self.buffer);
        allocator.free(self.output);
        allocator.free(self.user);
        allocator.destroy(self);
    }

    pub fn send_message(self: *@This()) !void {
        const allocator = self.server.allocator.?;

        var req = try allocator.create(uv.uv_write_t);
        uv.uv_handle_set_data(@ptrCast(req), @ptrCast(self));
        self.uvbuf = uv.uv_buf_init(@ptrCast(&self.frame.fixed_buffer), 1024);
        _ = uv.uv_write(@ptrCast(req), @ptrCast(self.client), @ptrCast(&self.uvbuf), 1, &send_msg);
    }
};
