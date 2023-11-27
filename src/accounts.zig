const std = @import("std");

pub const CAN_READ = 1;
pub const CAN_WRITE = 1 << 1;
pub const CAN_EXECUTE = 1 << 2;

pub const Permission = struct {
    collection: []u8,
    mode: u8,
};

pub const Account = struct {
    password: [32]u8,
    
};

pub const AccountManager = struct {
    accounts: std.StringHashMap(Account),

    pub fn init(allocator: std.mem.Allocator) !AccountManager {
        return .{
            .accounts = std.StringHashMap(Account).init(allocator)
        };
    }

    pub fn sha256(pass: []const u8, out: *[32]u8) void {
        var hash = std.crypto.hash.sha2.Sha256.init(.{});
        hash.update(pass);
        hash.final(out[0..32]);
    }

    pub fn register(self: *AccountManager, username: []const u8, account: Account) !void {
        try self.accounts.put(username, account);
    }

    pub fn login(self: *AccountManager, username: []const u8, encrypted_password: []const u8) bool {
         const acc = self.accounts.getPtr(username);
         if (acc) |l| {
            if (encrypted_password.len != 32) return false;
            return std.mem.eql(u8, l.password[0..], encrypted_password);
         }
         return false;
    }

    pub fn deinit(self: *AccountManager) void {
        self.accounts.deinit();
    }
};
