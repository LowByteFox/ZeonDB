const std = @import("std");
const xev = @import("xev");

pub fn copy_over(buff: []u8, start: usize, str: []const u8) void {
    for (0..str.len) |i| {
        buff[i + start] = str[i];
    }
}

const Data = struct {
    allocator: *const std.mem.Allocator,
    tmpbuff: [1024]u8,
    buffer: ?[]u8,
    connection: xev.TCP,
    read: xev.Completion,
    written: usize,
};

fn getin(allocator: std.mem.Allocator) ![]u8 {
    const stdin = std.io.getStdIn().reader();

    var buff: [1024]u8 = undefined;
    var data: ?[]u8 = null;
    var bytes_read: usize = 1;

    while (bytes_read > 0) {
        bytes_read = (try stdin.readUntilDelimiter(&buff, '\n')).len;
        if (data == null) {
            data = try allocator.alloc(u8, bytes_read);
            @memcpy(data.?, buff[0..bytes_read]);
            break;
        }
        data = try allocator.realloc(data.?, data.?.len + bytes_read);
        copy_over(data.?, data.?.len - bytes_read, buff[0..bytes_read]);
    }

    return data.?;
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    defer std.debug.assert(gpa.deinit() == .ok);
    
    var loop = try xev.Loop.init(.{});
    defer loop.deinit();

    var address = try std.net.Address.parseIp4("127.0.0.1", 6748);

    const client = try xev.TCP.init(address);

    var compl: xev.Completion = undefined;

    client.connect(&loop, &compl, address, std.mem.Allocator, @constCast(&allocator), &on_connect);

    try loop.run(.until_done);
}

fn on_connect(allocator: ?*std.mem.Allocator, l: *xev.Loop, c: *xev.Completion, server: xev.TCP, r: xev.TCP.ConnectError!void) xev.CallbackAction {
    _ = r catch unreachable;
    var data = allocator.?.create(Data) catch unreachable;
    data.allocator = allocator.?;
    data.tmpbuff = undefined;
    data.buffer = null;
    data.connection = server;
    data.written = 0;

    std.debug.print("> ", .{});

    var in = getin(data.allocator.*) catch unreachable;
    data.buffer = std.fmt.allocPrint(data.allocator.*, "{d}{s}", .{in.len, in}) catch unreachable;
    allocator.?.free(in);

    data.connection.write(l, c, .{ .slice = data.buffer.? }, Data, data, &on_write);

    return .disarm;
}

pub fn on_read(ud: ?*Data, l: *xev.Loop, c: *xev.Completion, _: xev.TCP, _: xev.ReadBuffer, r: xev.TCP.ReadError!usize) xev.CallbackAction {

    var bytes_read = r catch unreachable;

    const allocator = ud.?.allocator;

    if (ud.?.buffer == null) {
        var status = std.fmt.parseInt(i8, ud.?.tmpbuff[0..1], 10) catch {
            return .disarm;
        };

        if (status == 0) {
            std.debug.print("> ", .{});

            var in = getin(allocator.*) catch unreachable;
            ud.?.buffer = std.fmt.allocPrint(allocator.*, "{d}{s}", .{in.len, in}) catch unreachable;
            allocator.free(in);
            ud.?.tmpbuff = undefined;
            ud.?.written = 0;

            ud.?.connection.write(l, c, .{ .slice = ud.?.buffer.? }, Data, ud.?, &on_write);
            return .disarm;
        }

        var i: usize = 2;
        for (i..bytes_read) |index| {
            if (!std.ascii.isDigit(ud.?.tmpbuff[index])) {
                break;
            }
            i += 1;
        }
        
        var len = std.fmt.parseInt(usize, ud.?.tmpbuff[2..i], 10) catch {
            return .disarm;
        };
        i += 1; // space

        ud.?.buffer = allocator.allocSentinel(u8, len, 0) catch {
            return .disarm;
        };

        @memset(ud.?.buffer.?, 0);
        @memcpy(ud.?.buffer.?[0..(bytes_read - i)], ud.?.tmpbuff[i..bytes_read]);

        ud.?.written = bytes_read - i;
    } else {
        if (bytes_read > ud.?.buffer.?.len - ud.?.written) {
            bytes_read = ud.?.buffer.?.len - ud.?.written;
        }
        @memcpy(ud.?.buffer.?[ud.?.written..(ud.?.written + bytes_read)], ud.?.tmpbuff[0..bytes_read]);
        ud.?.written += bytes_read;
    }

    if (ud.?.written >= ud.?.buffer.?.len) {
        std.debug.print("{s}\n", .{ud.?.buffer.?});
        std.debug.print("> ", .{});

        var in = getin(allocator.*) catch unreachable;
        ud.?.buffer = std.fmt.allocPrint(allocator.*, "{d}{s}", .{in.len, in}) catch unreachable;
        allocator.free(in);
        ud.?.tmpbuff = undefined;
        ud.?.written = 0;

        ud.?.connection.write(l, c, .{ .slice = ud.?.buffer.? }, Data, ud.?, &on_write);
        return .disarm;
    }
    return .rearm;
}

pub fn on_write(ud: ?*Data, l: *xev.Loop, c: *xev.Completion, _: xev.TCP, _: xev.WriteBuffer, r: xev.TCP.WriteError!usize) xev.CallbackAction {
    _ = r catch unreachable;
    ud.?.allocator.free(ud.?.buffer.?);
    ud.?.buffer = null;
    @memset(ud.?.tmpbuff[0..1024], 0);
    ud.?.connection.read(l, c, .{ .slice = &ud.?.tmpbuff }, Data, ud.?, &on_read);
    return .disarm;
}
