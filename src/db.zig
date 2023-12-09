const std = @import("std");
const collection = @import("collection.zig");
const config = @import("config.zig");
const accounts = @import("accounts.zig");
const parser = @import("zql/parser.zig");
const network = @import("networking/loop.zig");
const types = @import("types.zig");
const ctx = @import("zql/ctx.zig");
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
        try self.net.run(self, &allocator);
    }

    pub fn execute(self: *DB, script: [:0]u8, allocator: std.mem.Allocator) !ctx.ZqlTrace {
        var parse = parser.Parser.init(&self.db, script);
        var args = try parse.parse(allocator);
        defer args.deinit();

        var shared_buffer: ?*types.Value = null;

        for (args.items) |*context| {
            defer context.deinit(allocator);
            var err = context.execute(shared_buffer, allocator) catch |e| {
                if (shared_buffer) |shared| {
                    types.dispose(shared, allocator);
                }
                return e;
            };

            if (err) |e| {
                return .{ .value = null, .err = e };
            }

            if (context.err) |e| {
                return .{ .value = null, .err = e };
            }

            shared_buffer = context.buffer;
        }

        return .{ .value = shared_buffer, .err = null };
    }
};
