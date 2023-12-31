const std = @import("std");

pub fn strdup(buff: []const u8, allocator: std.mem.Allocator) ![]u8 {
    var target = try allocator.alloc(u8, buff.len);
    @memcpy(target, buff);
    return target;
}

pub fn copy_over(buff: []u8, start: usize, str: []const u8) void {
    for (0..str.len) |i| {
        buff[i + start] = str[i];
    }
}

pub fn includes(buff: []const u8, char: u8) bool {
    for (buff) |c| {
        if (c == char) return true;
    }
    return false;
}

pub fn indexof(buff: []const u8, char: u8) usize {
    for (buff,0..) |c, i| {
        if (c == char) return i;
    }
    return 0;
}
