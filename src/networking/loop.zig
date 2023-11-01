const xev = @import("xev");
const std = @import("std");

pub fn on_accept(ud: ?*Server, l: *xev.Loop, _: *xev.Completion, connection: xev.TCP.AcceptError!xev.TCP) xev.CallbackAction {
    _ = ud;
    std.debug.print("{any}\n", .{connection catch unreachable});
    _ = l;
    return .rearm;
}

pub const Server = struct {
    loop: xev.Loop,
    socket: xev.TCP,
    address: std.net.Address,
    completion: xev.Completion,
    port: u16,
    buff: [1024]u8,

    pub fn init(port: u16) !Server {
        var address = try std.net.Address.parseIp4("127.0.0.1", port);

        return Server {
            .loop = try xev.Loop.init(.{}),
            .socket = try xev.TCP.init(address),
            .address = address,
            .completion = undefined,
            .port = port,
            .buff = undefined
        };
    }

    pub fn run(self: *@This()) !void {
        try self.socket.bind(self.address);
        try self.socket.listen(1);

        self.socket.accept(&self.loop, &self.completion, @This(), self, &on_accept);

        try self.loop.run(.until_done);
    }

    pub fn deinit(self: *@This()) void {
        self.loop.deinit();
    }
};
