// [type#LEVEL]:line MSG
const std = @import("std");

pub const scopes = [_]std.log.ScopeLevel{
    .{ .scope = .accounts, .level = .debug },
    .{ .scope = .parser, .level = .debug },
    .{ .scope = .ctx, .level = .debug },
    .{ .scope = .cmd, .level = .debug },
    .{ .scope = .collection, .level = .debug },
};

pub const options = struct {
    pub const log_level = .debug;

    pub const logFn = log;
};

pub fn log(comptime level: std.log.Level, comptime scope: @TypeOf(.EnumLiteral), comptime fmt: []const u8, args: anytype) void {
    const scope_level = "[" ++ switch (scope) {
        .accounts, .parser, .ctx, .cmd, .collection => @tagName(scope),
        else => "???"
    };

    const prefix = scope_level ++ "#" ++ comptime level.asText() ++ "]";

    std.debug.getStderrMutex().lock();
    defer std.debug.getStderrMutex().unlock();
    const stderr = std.io.getStdErr().writer();
    nosuspend stderr.print(prefix ++ fmt ++ "\n", args) catch return;
}
