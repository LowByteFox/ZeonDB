const std = @import("std");

pub fn AutoPtr(comptime T: type) type {
    return struct {
        ref: u32,
        allocator: std.mem.Allocator,
        value: T,
        on_free: ?*const fn (value: *T, allocator: std.mem.Allocator) void,

        const Self = @This();

        pub fn init(allocator: std.mem.Allocator, value: T) !*Self {
            var ptr = try allocator.create(Self);
            ptr.ref = 1;
            ptr.value = value;
            ptr.allocator = allocator;
            ptr.on_free = null;
            return ptr;
        }

        pub fn set_on_free(self: *Self, func: *const fn (value: *T, allocator: std.mem.Allocator) void) void {
            self.on_free = func;
        }

        pub fn deinit(self: *Self) void {
            self.ref -= 1;
            if (self.ref == 0) {
                if (self.on_free) |f| {
                    f(&self.value, self.allocator);
                }
                self.allocator.destroy(self);
            }
        }

        pub fn move(self: *Self) *Self {
            self.ref += 1;
            return self;
        }
    };
}
