const std = @import("std");
const collection = @import("collection.zig");
const config = @import("config.zig");
const network = @import("networking/loop.zig");
const accounts = @import("accounts.zig");
const toml = @import("ztoml");

pub const DB = struct {
    db: collection.Collection,
    conf: toml.Parsed(config.Config),
    net: network.Server,
    accs: accounts.AccountManager,

    pub fn init(allocator: std.mem.Allocator) !DB {
        var db = try collection.Collection.init(allocator);
        var parsed = try config.load_config(allocator);
        var server: ?network.Server = null;
        if (parsed.value.communication) |comm| {
            if (comm.ip) |ip| {
                if (ip.enable) {
                    if (ip.port) |port| {
                        server = try network.Server.init(port);
                    } else {
                        server = try network.Server.init(6748);
                    }
                } else {
                    // TODO: ERROR
                }
            }
        }

        var mgr = try accounts.AccountManager.init(allocator);

        return .{
            .db = db,
            .conf = parsed,
            .net = server.?,
            .accs = mgr,
        };
    }

    pub fn deinit(self: *DB, allocator: std.mem.Allocator) void {
        self.accs.deinit();
        self.net.deinit();
        self.db.deinit(allocator);
        self.conf.deinit();
    }

    pub fn run(self: *DB, allocator: std.mem.Allocator) !void {
        try self.net.run(&self.db, &allocator);
    }
};
