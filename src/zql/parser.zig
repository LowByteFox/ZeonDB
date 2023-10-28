const types = @import("../types.zig");
const std = @import("std");
const ctx = @import("ctx.zig");
const lex = @import("lexer.zig");
const err = @import("errors.zig");
const collection = @import("../collection.zig");

fn test_fun(ct: *const ctx.ZqlContext, allocator: std.mem.Allocator) anyerror!void {
    _ = allocator;
    std.debug.print("{s}\n", .{ ct.args.items[0].String });

    const keys = [_][]const u8{
        "hello",
        "hello2",
        "nice",
        "num1",
        "float1",
        "float2"
    };

    for (keys) |key| {
        var val = ct.args.items[1].Collection.get(key).?;
        switch (val.*) {
            types.Value.String => {
                std.debug.print("{s} = {s}\n", .{ key, val.String });
            },
            types.Value.Int => {
                std.debug.print("{s} = {}\n", .{ key, val.Int });
            },
            types.Value.Float => {
                std.debug.print("{s} = {}\n", .{ key, val.Float });
            },
            types.Value.Bool => {
                std.debug.print("{s} = {}\n", .{ key, val.Bool });
            },
            types.Value.Array => {
                std.debug.print("{s}[0] = {s}\n", .{ key, val.Array.items[0].String });
                std.debug.print("{s}[0]inner = {}\n", .{ key, val.Array.items[1].Collection.get("inner").?.Bool });
            },
            else => {
                std.debug.print("{s} = {any}\n", .{ key, val });
            }
        }
    }
}

pub fn strdup(buff: []u8, allocator: std.mem.Allocator) ![]u8 {
    var target = try allocator.alloc(u8, buff.len);
    @memcpy(target, buff);
    return target;
}

const commands = std.ComptimeStringMap(ctx.ZqlCmd, .{
    .{"test", ctx.ZqlCmd{ .arg_count = 2, .func = test_fun }}
});

pub const Parser = struct {
    db: *collection.Collection,
    lexer: lex.Lexer,
    ctx: ?ctx.ZqlContext,

    pub fn init(db: *collection.Collection, code: [:0]const u8) Parser {
        return Parser{
            .db = db,
            .lexer = lex.Lexer.init(code),
            .ctx = null
        };
    }

    fn clean_value(self: *@This(), arg: *types.Value, allocator: std.mem.Allocator) void {
        switch (arg.*) {
            types.Value.String => {
                allocator.free(arg.String);
            },
            types.Value.Array => {
                self.clean_array(&arg.Array, allocator);
                arg.Array.deinit();
            },
            types.Value.Collection => {
                arg.Collection.deinit(allocator);
            },
            else => {}
        }
        allocator.destroy(arg);
    }

    fn clean_array(self: *@This(), arr: *std.ArrayList(*types.Value), allocator: std.mem.Allocator) void {
        for (arr.items) |i| {
            var item = @constCast(i);
            self.clean_value(item, allocator);
        }
    }

    fn dispose_ctx(self: *@This(), allocator: std.mem.Allocator) void {
        for (self.ctx.?.args.items) |const_arg| {
            var arg = @constCast(const_arg);
            self.clean_value(arg, allocator);
        }

        self.ctx.?.args.clearAndFree();
    }

    pub fn run(self: *@This(), allocator: std.mem.Allocator) !void {
        self.ctx = ctx.ZqlContext.init(self.db, allocator);
        defer self.ctx.?.deinit();
        defer self.dispose_ctx(allocator);
        
        var tok = try self.lexer.parse_token(allocator);
        defer allocator.free(tok.text);

        if (tok.type != lex.TokenTypes.identifier) {
            return err.Errors.ExpectedCommandError;
        }

        while (tok.type != lex.TokenTypes.eof) {
            if (commands.get(tok.text)) |command| {
                for (0..@intCast(command.arg_count)) |i| {
                    _ = i;
                    var arg = self.parse_value(allocator) catch |e| {
                        return e;
                    };
                    try self.ctx.?.add_arg(arg);
                }

                command.func(&self.ctx.?, allocator) catch |e| {
                    return e;
                };

            } else {
                return err.Errors.ExpectedCommandError;
            }
            allocator.free(tok.text);
            tok = try self.lexer.parse_token(allocator);
        }
    }

    fn init_value(self: *@This(), val: types.Value, allocator: std.mem.Allocator) !*types.Value {
        _ = self;
        var v = try allocator.create(types.Value);
        v.* = val;
        return v;
    }

    fn test_identifier(self: *@This(), tok: lex.Token, allocator: std.mem.Allocator) !?*types.Value {
        if (commands.has(tok.text)) {
            return null;
        }

        return self.init_value(.{ .String = try strdup(tok.text, allocator) }, allocator);
    }

    fn parse_primitive_value(self: *@This(), tok: lex.Token, allocator: std.mem.Allocator) anyerror!?*types.Value { 
        switch(tok.type) {
            lex.TokenTypes.identifier => {
                return try self.test_identifier(tok, allocator);
            },
            lex.TokenTypes.string => {
                return try self.init_value(.{ .String = try strdup(tok.text, allocator) }, allocator);
            },
            lex.TokenTypes.int => {
                return try self.init_value(.{ .Int = try std.fmt.parseInt(i64, tok.text, 10) }, allocator);
            },
            lex.TokenTypes.float => {
                return try self.init_value(.{ .Float = try std.fmt.parseFloat(f64, tok.text) }, allocator);
            },
            lex.TokenTypes.bool => {
                var bool_val = false;

                if (std.mem.eql(u8, "true", tok.text)) {
                    bool_val = true;
                }

                return try self.init_value(.{ .Bool = bool_val }, allocator);
            },
            lex.TokenTypes.lsquarebracket, lex.TokenTypes.lsquiglybracket => {
                try self.lexer.step_back(1);
                return try self.parse_value(allocator);
            },
            else => {
                return null;
            }
        }
    }

    fn parse_value(self: *@This(), allocator: std.mem.Allocator) !*types.Value {
        var tok = try self.lexer.parse_token(allocator);
        defer allocator.free(tok.text);
        if (tok.type == lex.TokenTypes.eof) {
            return err.Errors.GotEofError;
        }

        if (tok.type == lex.TokenTypes.lsquarebracket) {
            var value_array = std.ArrayList(*types.Value).init(allocator);

            while (true) {
                allocator.free(tok.text);
                tok = try self.lexer.parse_token(allocator);
                if (tok.type == lex.TokenTypes.rsquarebracket) {
                    break;
                } else if (tok.type == lex.TokenTypes.comma) {
                    continue;
                } else if (tok.type == lex.TokenTypes.eof) {
                    for (value_array.items) |i| {
                        var item = @constCast(i);
                        self.clean_value(item, allocator);
                    }
                    value_array.deinit();
                    return err.Errors.GotEofError;
                }

                var array_val: ?*types.Value = try self.parse_primitive_value(tok, allocator);

                if (array_val == null) {
                    for (value_array.items) |i| {
                        var item = @constCast(i);
                        self.clean_value(item, allocator);
                    }
                    value_array.deinit();

                    return err.Errors.IdentifierNotExpected;
                }

                try value_array.append(array_val.?);
            }

            return try self.init_value(.{ .Array = value_array }, allocator);
        } else if (tok.type == lex.TokenTypes.lsquiglybracket) {
            var obj = try collection.Collection.init(allocator);

            while (true) {
                allocator.free(tok.text);
                tok = try self.lexer.parse_token(allocator);
                if (tok.type == lex.TokenTypes.rsquiglybracket) {
                    break;
                }

                if (tok.type != lex.TokenTypes.string and
                    tok.type != lex.TokenTypes.identifier) {
                    obj.deinit(allocator);
                    return err.Errors.TypeError;
                }

                var obj_key = try strdup(tok.text, allocator);
                defer allocator.free(obj_key);

                allocator.free(tok.text);
                tok = try self.lexer.parse_token(allocator);

                var obj_value: ?*types.Value = null;

                if (tok.type == lex.TokenTypes.colon) {
                    allocator.free(tok.text);
                    tok = try self.lexer.parse_token(allocator);
                    obj_value = try self.parse_primitive_value(tok, allocator);
                }   else {
                    obj_value = try self.parse_primitive_value(tok, allocator);
                }
                if (obj_value == null) {
                    obj.deinit(allocator);
                    return err.Errors.IdentifierNotExpected;
                }

                try obj.add(obj_key, obj_value.?, allocator);

                allocator.free(tok.text);
                tok = try self.lexer.parse_token(allocator);
                if (tok.type != lex.TokenTypes.comma) {
                    try self.lexer.step_back(@intCast(tok.text.len));
                }
            }

            return try self.init_value(.{ .Collection = obj }, allocator);
        }

        var val: ?*types.Value = try self.parse_primitive_value(tok, allocator);

        if (val != null) {
            return val.?;
        }

        return err.Errors.IdentifierNotExpected;
    }

    pub fn testfun(self: *Parser, allocator: std.mem.Allocator) !void {
        var ct = ctx.ZqlContext.init(self.db, allocator);
        defer ct.deinit();
        try ct.add_arg(types.Value{ .Int = 77 });
        commands.get("test").?.func(&ct);
    }
};
