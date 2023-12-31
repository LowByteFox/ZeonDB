const std = @import("std");
const context = @import("ctx.zig");
const types = @import("../types.zig");
const collection = @import("../collection.zig");
const accs = @import("../accounts.zig");
const cmds = @import("commands/main.zig");

pub const commands = std.ComptimeStringMap(context.ZqlFunc, .{
    .{
        "set", cmds.set,
    },
    .{
        "get", cmds.get,
    },
    .{
        "auth", cmds.auth,
    }
});
