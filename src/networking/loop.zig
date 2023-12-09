const uv = @import("uv.zig");
const std = @import("std");
const db = @import("../db.zig");
const cl = @import("client.zig");
const utils = @import("../utils.zig");

pub fn extract_data(comptime T: type, uv_data: [*c]uv.uv_handle_type) *T {
    var data = uv.uv_handle_get_data(@ptrCast(@alignCast(uv_data)));
    var res: *T = @ptrCast(@alignCast(data.?));
    return res;
}

fn on_connect(tcp: [*c]uv.uv_stream_t, status: i32) callconv(.C) void {
    if (status < 0) {
        std.debug.print("libuv connection error {s}\n", .{uv.uv_strerror(status)});
        return;
    }
    var server = extract_data(Server, @ptrCast(tcp));
    var client = server.allocator.?.create(uv.uv_tcp_t) catch unreachable;
    _ = uv.uv_tcp_init(server.loop, @ptrCast(client));

    var userdata = cl.Client.init(server.allocator.?.*, server, client) catch unreachable;
    if (uv.uv_accept(tcp, @ptrCast(client)) == 0) {
        uv.uv_handle_set_data(@ptrCast(client), @ptrCast(userdata));
        userdata.frame.status = @enumFromInt(0);
        userdata.frame.target_length = 0;
        userdata.frame.to_buffer(null);
        
        userdata.send_message() catch unreachable;
        _ = uv.uv_read_start(@ptrCast(client), &alloc_buff, &get_frame);
    } else {
        uv.uv_close(@ptrCast(client), null);
    }
}

fn alloc_buff(handle: [*c]uv.uv_handle_t, suggest: usize, buf: [*c]uv.uv_buf_t) callconv(.C) void {
    _ = suggest;
    var data = extract_data(cl.Client, @ptrCast(handle));
    var zigbuf: *uv.uv_buf_t = @ptrCast(buf);
    const allocator = data.server.allocator.?;

    if (data.buffer.len == 0) {
        data.buffer = allocator.realloc(data.buffer, 1024) catch unreachable;
        var buffer: [*]u8 = @ptrCast(data.buffer);

        zigbuf.len = 1024;
        zigbuf.base = buffer;
        return;
    }

    if (data.buffer.len > 0) {
        var buffer: [*]u8 = @ptrCast(data.buffer);
        zigbuf.len = 1024 - data.buffer.len;
        zigbuf.base = buffer + data.buffer.len;
        return;
    }
}

fn handle_frame(self: *cl.Client) void {
    switch (self.frame.status) {
        .Ok => {},
        .Auth => {
            var buff = self.frame.read_buffer();
            var index = utils.indexof(buff, ' ');
            var username = buff[0..index];
            index += 1;
            var password = buff[index..index + 32];
            if (self.server.db.?.accs.login(username, password)) {
                self.login(username) catch {
                    self.frame.status = @enumFromInt(3);
                    var msg: [1015]u8 = undefined;
                    utils.copy_over(&msg, 0, "XX Memory error");
                    self.frame.write_buffer(&msg);
                    self.frame.to_buffer(msg.len);
                    self.send_message() catch unreachable;
                    return;
                };
                self.frame.status = @enumFromInt(3);
                var msg: [1015]u8 = undefined;
                @memset(&msg, 0);
                utils.copy_over(&msg, 0, "OK");
                self.frame.write_buffer(&msg);
                self.frame.to_buffer(msg.len);
                self.send_message() catch unreachable;
            } else {
                self.frame.status = @enumFromInt(3);
                var msg: [1015]u8 = undefined;
                @memset(&msg, 0);
                utils.copy_over(&msg, 0, "ER Bad username or password");
                self.frame.write_buffer(&msg);
                self.frame.to_buffer(msg.len);
                self.send_message() catch unreachable;
            }
        },
        else => {
            @panic("implementing");
        },
    }
}

fn get_frame(stream: [*c]uv.uv_stream_t, nread: isize, buf: [*c]const uv.uv_buf_t) callconv(.C) void {
    _ = buf;
    var data = extract_data(cl.Client, @ptrCast(stream));
    const allocator = data.server.allocator.?;

    if (nread == uv.UV_EOF) {
        @panic("TODO: Client died");
    }

    if (nread > 0) {
        if (data.buffer.len == 1024) {
            defer data.buffer = allocator.realloc(data.buffer, 0) catch unreachable;

            @memcpy(&data.frame.fixed_buffer, data.buffer);
            data.frame.from_buffer();
            handle_frame(data);
        }
    } else if (nread == 0) {
    } else {
    }
}

pub const Server = struct {
    address: std.net.Address,
    port: u16,
    allocator: ?*const std.mem.Allocator,
    db: ?*db.DB,
    loop: [*c]uv.uv_loop_t,

    pub fn init(port: u16) !Server {
        var address = try std.net.Address.parseIp4("127.0.0.1", port);

        return Server {
            .address = address,
            .port = port,
            .allocator = null,
            .db = null,
            .loop = uv.uv_default_loop(),
        };
    }

    pub fn run(self: *@This(), database: *db.DB, allocator: *const std.mem.Allocator) !void {

        self.allocator = allocator;
        self.db = database;

        var server: uv.uv_tcp_t = undefined;
        _ = uv.uv_tcp_init(self.loop, @ptrCast(&server));
        _ = uv.uv_tcp_bind(@ptrCast(&server), @ptrCast(&self.address.in.sa), 0);

        var res = uv.uv_listen(@ptrCast(&server), 128, &on_connect);

        if (res > 0) {
            std.debug.print("Error, unable to serve!\n", .{});
            return;
        }

        uv.uv_handle_set_data(@ptrCast(&server), @ptrCast(self));

        std.debug.print("Started serving at {any}!\n", .{self.address});
        _ = uv.uv_run(self.loop, uv.UV_RUN_DEFAULT);
    }

    pub fn deinit(self: *@This()) void {
        _ = self;
    }
};
