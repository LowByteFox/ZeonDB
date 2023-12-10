const uv = @import("uv.zig");
const std = @import("std");
const db = @import("../db.zig");
const cl = @import("client.zig");
const utils = @import("../utils.zig");
const types = @import("../types.zig");

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
    var client: uv.uv_tcp_t = undefined;
    var userdata = cl.Client.init(server.allocator.?.*, server, client) catch unreachable;
    _ = uv.uv_tcp_init(server.loop, @ptrCast(&userdata.client));

    if (uv.uv_accept(tcp, @ptrCast(&userdata.client)) == 0) {
        uv.uv_handle_set_data(@ptrCast(&userdata.client), @ptrCast(userdata));
        userdata.frame.status = @enumFromInt(0);
        userdata.frame.target_length = 0;
        userdata.frame.to_buffer(null);
        
        userdata.send_message() catch unreachable;
        _ = uv.uv_read_start(@ptrCast(&userdata.client), &alloc_buff, &get_frame);
    } else {
        uv.uv_close(@ptrCast(&userdata.client), null);
        userdata.deinit(server.allocator.?.*);
    }
}

fn alloc_buff(handle: [*c]uv.uv_handle_t, suggest: usize, buf: [*c]uv.uv_buf_t) callconv(.C) void {
    _ = suggest;
    var data = extract_data(cl.Client, @ptrCast(handle));
    var zigbuf: *uv.uv_buf_t = @ptrCast(buf);

    if (data.read == 0) {
        data.buffer = @ptrCast(std.c.malloc(1024));
    }

    if (data.read > 0) {
        zigbuf.len = 1024 - data.read;
        zigbuf.base = data.buffer + data.read;
        return;
    }

    zigbuf.len = 1024;
    zigbuf.base = data.buffer;
}

fn handle_frame(self: *cl.Client) void {
    const allocator = self.server.allocator.?;

    switch (self.frame.status) {
        .Ok => {},
        .Auth => {
            var msg: [1015]u8 = undefined;
            var buff = self.frame.read_buffer();
            var index = utils.indexof(buff, ' ');
            var username = buff[0..index];
            index += 1;
            var password = buff[index..index + 32];
            if (self.server.db.?.accs.login(username, password)) {
                self.login(username) catch {
                    self.frame.status = @enumFromInt(3);
                    utils.copy_over(&msg, 0, "XX Memory error");
                    self.frame.write_buffer(&msg);
                    self.frame.to_buffer(msg.len);
                    self.send_message() catch unreachable;
                    return;
                };
                self.frame.status = @enumFromInt(3);
                @memset(&msg, 0);
                utils.copy_over(&msg, 0, "OK");
                self.frame.write_buffer(&msg);
                self.frame.to_buffer(msg.len);
                self.send_message() catch unreachable;
                self.user = allocator.realloc(self.user, username.len) catch unreachable;
                @memcpy(self.user, username);
            } else {
                self.frame.status = @enumFromInt(3);
                @memset(&msg, 0);
                utils.copy_over(&msg, 0, "ER Bad username or password");
                self.frame.write_buffer(&msg);
                self.frame.to_buffer(msg.len);
                self.send_message() catch unreachable;
            }
        },
        .Command => {
            if (self.command_buffer == null) {
                var buff = self.frame.read_buffer();

                self.command_buffer = allocator.allocSentinel(u8, self.frame.target_length, 0) catch unreachable;
                if (self.frame.target_length > 1015) {
                    @memcpy(self.command_buffer.?[0..1015], buff[0..1015]);
                    self.command_written += 1015;
                } else {
                    @memcpy(self.command_buffer.?, buff);
                    // rehandle the thing
                    handle_frame(self);
                }
                return;
            }

            defer {
                allocator.free(self.command_buffer.?);
                self.command_written = 0;
                self.command_buffer = null;
            }

            var buffer: [1015]u8 = undefined;

            var result = self.server.db.?.execute(self.command_buffer.?, allocator.*) catch |e| {
                var printed = std.fmt.bufPrint(&buffer, "{}", .{e}) catch unreachable; 
                self.frame.status = .Error;
                self.frame.to_buffer(printed.len);
                self.frame.write_buffer(buffer[0..1015]);
                self.send_message() catch unreachable;
                return;
            };

            if (result.err) |e| {
                var printed = std.fmt.bufPrint(&buffer, "{s}", .{e}) catch unreachable;
                defer allocator.free(e);
                self.frame.status = .Error;
                self.frame.to_buffer(printed.len);
                self.frame.write_buffer(buffer[0..1015]);
                self.send_message() catch unreachable;
                return;
            }

            if (result.value) |v| {
                var str: []u8 = undefined;
                defer allocator.free(str);

                if (!std.mem.eql(u8, self.server.db.?.conf.value.format[0..3], "ZQL")) {
                    str = types.stringify(v, types.FormatType.JSON, allocator.*) catch unreachable;
                } else {
                    str = types.stringify(v, types.FormatType.ZQL, allocator.*) catch unreachable;
                }

                if (result.free_value) {
                    allocator.destroy(v);
                }

                var printed = std.fmt.bufPrint(&buffer, "{s}", .{str}) catch unreachable; 
                self.frame.status = .Command;
                self.frame.to_buffer(printed.len);
                self.frame.write_buffer(buffer[0..1015]);
                self.send_message() catch unreachable;
                return;
            }

            @memcpy(buffer[0..2], "OK");
            self.frame.status = .Command;
            self.frame.to_buffer(2);
            self.frame.write_buffer(buffer[0..1015]);
            self.send_message() catch unreachable;
        },
        else => {
            @panic("Implementing rest of others");
        },
    }
}

fn get_frame(stream: [*c]uv.uv_stream_t, nread: isize, buf: [*c]const uv.uv_buf_t) callconv(.C) void {
    _ = buf;
    var data = extract_data(cl.Client, @ptrCast(stream));

    if (nread == uv.UV_EOF) {
        _ = uv.uv_read_stop(stream);
        data.deinit(data.server.allocator.?.*);
        return;
    }

    if (nread > 0) {
        data.read += @intCast(nread);

        if (data.read == 1024) {
            defer std.c.free(data.buffer);
            defer data.buffer = null;
            defer data.read = 0;

            if (data.command_buffer != null) {
                @memcpy(data.command_buffer.?, data.buffer[0..1024]);
                data.command_written += 1024;
                return;
            }
            @memcpy(&data.frame.fixed_buffer, data.buffer[0..1024]);
            data.frame.from_buffer();
            handle_frame(data);
        }
    } else if (nread == 0) {
    } else {
        std.debug.print("{s}\n", .{uv.uv_strerror(@intCast(nread))});
        _ = uv.uv_stop(data.server.loop);
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
