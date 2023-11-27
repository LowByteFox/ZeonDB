const std = @import("std");

pub const ZeonFrame = struct {
    status: ZeonFrameStatus,
    target_length: ?u64,
    fixed_buffer: [1024]u8,

    pub fn to_buffer(self: *@This(), length: ?u64) void {
        std.mem.writeInt(u8, self.fixed_buffer[0..1], @intFromEnum(self.status), std.builtin.Endian.Little);
        switch (self.status) {
            .Command, .Error, .Auth, .KeyExchange => {
                if (length == null) {
                    @panic("Length was expected but not null!");
                }
                std.mem.writeInt(u64, self.fixed_buffer[1..9], length.?, std.builtin.Endian.Little);
            },
            else => {
                @memset(self.fixed_buffer[1..1024], 0);
            }
        }
    }

    pub fn from_buffer(self: *@This()) void {
        self.status = @enumFromInt(std.mem.readInt(u8, self.fixed_buffer[0..1], std.builtin.Endian.Little));
        switch (self.status) {
            .Command, .Error, .Auth, .KeyExchange => {
                self.target_length = std.mem.readInt(u64, self.fixed_buffer[1..9], std.builtin.Endian.Little);
            },
            else => {
            }
        }
    }
};

pub const ZeonFrameStatus = enum(u8) {
    Ok = 0,
    Command = 1,
    Error = 2,
    Auth = 3,
    KeyExchange = 4,
};
