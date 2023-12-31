const builtin = @import("builtin");

pub usingnamespace switch (builtin.zig_backend) {
    .stage1 => @cImport({
        @cInclude("uv.h");
    }),

    // Workaround for:
    // https://github.com/ziglang/zig/issues/12325
    else => switch (builtin.os.tag) {
        .openbsd => @import("uv_openbsd.zig"),
        else => @compileError("unsupported OS for now, see this line"),
    },
};
