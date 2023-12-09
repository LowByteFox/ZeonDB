const std = @import("std");
const networking = @import("networking");
const uv = networking.uv;

extern "c" fn memcpy(*anyopaque, *anyopaque, usize) callconv(.C) ?*anyopaque;

pub const ZeonConnection = extern struct {
    loop: [*c]uv.uv_loop_t,
    tcp: uv.uv_tcp_t,
    conn: uv.uv_connect_t,
    addr: std.os.sockaddr.in,
    inbuff: [*c]u8,
    read: usize,
    authenticated: bool,
    frame: networking.frame.ZeonFrame,
};

fn on_connect(req: [*c]uv.uv_connect_t, status: i32) callconv(.C) void {
    if (status < 0) {
        std.debug.print("Could not connect to ZeonDB! {s}\n", .{uv.uv_strerror(status)});
    }
    _ = req;
}

fn auth_write(req: [*c]uv.uv_write_t, status: i32) callconv(.C) void {
    var data = networking.loop.extract_data(ZeonConnection, @ptrCast(req));

    if (status < 0) {
        std.debug.print("Could not authenticate to ZeonDB! {s}\n", .{uv.uv_strerror(status)});
        return;
    }
    std.c.free(req);

    _ = uv.uv_read_start(@ptrCast(&data.tcp), &alloc_buff, &on_read);
}

fn alloc_buff(handle: [*c]uv.uv_handle_t, suggest: usize, buf: [*c]uv.uv_buf_t) callconv(.C) void {
    _ = suggest;
    var data = networking.loop.extract_data(ZeonConnection, @ptrCast(handle));
    var zigbuf: *uv.uv_buf_t = @ptrCast(buf);

    if (data.read == 0) {
        data.inbuff = @ptrCast(std.c.malloc(1024));
    }

    if (data.read > 0) {
        zigbuf.len = 1024 - data.read;
        zigbuf.base = data.inbuff + data.read;
        return;
    }

    zigbuf.len = 1024;
    zigbuf.base = data.inbuff;
}

fn on_read(stream: [*c]uv.uv_stream_t, nread: isize, buf: [*c]const uv.uv_buf_t) callconv(.C) void {
    _ = buf;
    var data = networking.loop.extract_data(ZeonConnection, @ptrCast(stream));
    if (nread == uv.UV_EOF) {
        @panic("TODO: DB DIED");
    }

    if (nread > 0) {
        data.read += @intCast(nread);

        if (data.read == 1024) {
            defer std.c.free(data.inbuff);
            defer data.inbuff = null;
            defer data.read = 0;

            @memcpy(&data.frame.fixed_buffer, data.inbuff[0..1024]);
            data.frame.from_buffer();
            switch (data.frame.status) {
                .Ok => {
                    _ = uv.uv_read_stop(stream);
                    _ = uv.uv_stop(data.loop);
                },
                .Auth => {
                    var buff = data.frame.read_buffer();
                    _ = uv.uv_read_stop(stream);
                    _ = uv.uv_stop(data.loop);
                    if (std.mem.eql(u8, buff[0..2], "OK")) {
                        data.authenticated = true;
                    }
                },
                .KeyExchange => {
                    @panic("KeyExchange not implemented");
                },
                else => {
                    @panic("This was not expected?");
                },
            }
        }
    } else if (nread == 0) {
    } else {
    }
}

pub fn zeon_connection_init(ip: []const u8, port: u16) ?*ZeonConnection {
    var conn = std.c.malloc(@sizeOf(ZeonConnection));
    if (conn) |c| {
        var ptr: *ZeonConnection = @ptrCast(@alignCast(c));
        ptr.loop = uv.uv_default_loop();
        var addr = std.net.Address.parseIp4(ip, port) catch {
            zeon_connection_deinit(ptr);
            return null;
        };
        ptr.addr = addr.in.sa;
        ptr.tcp = undefined;
        ptr.conn = undefined;
        ptr.frame = undefined;
        ptr.inbuff = null;
        ptr.read = 0;
        ptr.authenticated = false;
        _ = uv.uv_tcp_init(ptr.loop, @ptrCast(&ptr.tcp));
        _ = uv.uv_tcp_connect(@ptrCast(&ptr.conn), @ptrCast(&ptr.tcp), @ptrCast(&ptr.addr), &on_connect);

        uv.uv_handle_set_data(@ptrCast(&ptr.tcp), @ptrCast(ptr));
        
        _ = uv.uv_read_start(@ptrCast(&ptr.tcp), &alloc_buff, &on_read);
        _ = uv.uv_run(ptr.loop, uv.UV_RUN_DEFAULT);
        return ptr;
    }
    return null;
}

fn sha256(pass: []const u8, out: *[32]u8) void {
    var hash = std.crypto.hash.sha2.Sha256.init(.{});
    hash.update(pass);
    hash.final(out[0..32]);
}

pub fn zeon_connection_auth(conn: *ZeonConnection, username: []const u8, password: []const u8) bool {
    var hash: [32]u8 = undefined;
    sha256(password, &hash);

    var buffer: [1015]u8 = undefined;
    var printed = std.fmt.bufPrint(&buffer, "{s} {s}", .{username, hash}) catch unreachable;
    conn.frame.status = .Auth;
    conn.frame.to_buffer(printed.len);
    conn.frame.write_buffer(buffer[0..1015]);

    var req: [*c]uv.uv_write_t = @ptrCast(@alignCast(std.c.malloc(@sizeOf(uv.uv_write_t)).?)); // TODO: secure
    uv.uv_handle_set_data(@ptrCast(req), @ptrCast(conn));
    var buf = uv.uv_buf_init(@ptrCast(&conn.frame.fixed_buffer), 1024);
    _ = uv.uv_write(@ptrCast(req), @ptrCast(&conn.tcp), @ptrCast(&buf), 1, &auth_write);
    _ = uv.uv_run(conn.loop, uv.UV_RUN_DEFAULT);
    return conn.authenticated;
}

pub fn zeon_connection_deinit(conn: *ZeonConnection) void {
    std.c.free(conn);
}
