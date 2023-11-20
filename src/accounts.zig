const std = @import("std");

pub const Account = struct {
    password: []u8,
};

pub const AccountManager = struct {
    accounts: std.StringHashMap(Account),

    pub fn init(allocator: std.mem.Allocator) !AccountManager {
        return .{
            .accounts = std.StringHashMap(Account).init(allocator)
        };
    }

    pub fn register(self: *AccountManager, username: []const u8, account: Account) !void {
        try self.accounts.put(username, account);
    }

    pub fn login(self: *AccountManager, username: []const u8, encrypted_password: []const u8) bool {
         const acc = self.accounts.getPtr(username);
         if (acc) |l| {
            if (encrypted_password.len != l.password.len) return false;
            return std.mem.eql(u8, l.password, encrypted_password);
         }
         return false;
    }

    pub fn deinit(self: *AccountManager) void {
        self.accounts.deinit();
    }
};
