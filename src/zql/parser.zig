const types = @import("../types.zig");
const std = @import("std");
const ctx = @import("ctx.zig");
const lex = @import("lexer.zig");
const err = @import("errors.zig");
const collection = @import("../collection.zig");
const cmds = @import("commands.zig");
const utils = @import("../utils.zig");

pub const Parser = struct {
    db: *collection.Collection,
    lexer: lex.Lexer,

    pub fn init(db: *collection.Collection, code: [:0]const u8) Parser {
        return Parser{
            .db = db,
            .lexer = lex.Lexer.init(code),
        };
    }

    pub fn parse(self: *@This(), allocator: std.mem.Allocator) !std.ArrayList(ctx.ZqlContext) {
        var contexts = std.ArrayList(ctx.ZqlContext).init(allocator);
        
        var tok = try self.lexer.parse_token();

        if (tok.type != lex.TokenTypes.identifier) {
            return err.Errors.ExpectedCommandError;
        }

        while (tok.type != lex.TokenTypes.eof) {
            if (cmds.commands.get(tok.text)) |command| {
                var context = ctx.ZqlContext.init(self.db, allocator);

                while (true) {
                    tok = try self.lexer.parse_token();
 
                    if ((tok.type == lex.TokenTypes.identifier and cmds.commands.get(tok.text) != null) or tok.type == lex.TokenTypes.eof or tok.type == lex.TokenTypes.semicolon) {
                        if (tok.type == lex.TokenTypes.identifier) {
                            try self.lexer.step_back(tok.text.len);
                        }
                        break;
                    }

                    var arg = try self.parse_value(tok, allocator);

                    try context.add_arg(arg);
                }

                context.set_fn(command);

                try contexts.append(context);
            } else {
                var context = ctx.ZqlContext.init(self.db, allocator);
                try context.add_arg(try self.init_trace_err(try std.fmt.allocPrint(allocator, "Invalid command or unexpected token at {}:{}!", .{tok.line, tok.col}), allocator));

                try contexts.append(context);
                return contexts;
            }
            tok = try self.lexer.parse_token();
        }

        return contexts;
    }

    fn init_value(self: *@This(), val: types.Value, allocator: std.mem.Allocator) !*types.Value {
        _ = self;
        var v = try allocator.create(types.Value);
        v.* = val;
        return v;
    }

    fn init_trace_val(self: *@This(), val: *types.Value, allocator: std.mem.Allocator) !*ctx.ZqlTrace {
        _ = self;
        var v = try allocator.create(ctx.ZqlTrace);
        v.value = val;
        v.err = null;
        return v;
    }

    fn init_trace_err(self: *@This(), error_msg: []u8, allocator: std.mem.Allocator) !*ctx.ZqlTrace {
        _ = self;
        var v = try allocator.create(ctx.ZqlTrace);
        v.value = null;
        v.err = error_msg;
        return v;
    }

    fn parse_primitive_value(self: *@This(), tok: lex.Token, allocator: std.mem.Allocator) anyerror!?*ctx.ZqlTrace { 
        switch(tok.type) {
            lex.TokenTypes.identifier => {
                return try self.init_trace_val(try self.init_value(.{ .String = try utils.strdup(tok.text, allocator) }, allocator), allocator);
            },
            lex.TokenTypes.string => {
                return try self.init_trace_val(try self.init_value(.{ .String = try utils.strdup(tok.text, allocator) }, allocator), allocator);
            },
            lex.TokenTypes.int => {
                return try self.init_trace_val(try self.init_value(.{ .Int = try std.fmt.parseInt(i64, tok.text, 10) }, allocator), allocator);
            },
            lex.TokenTypes.float => {
                return try self.init_trace_val(try self.init_value(.{ .Float = try std.fmt.parseFloat(f64, tok.text) }, allocator), allocator);
            },
            lex.TokenTypes.bool => {
                var bool_val = false;

                if (std.mem.eql(u8, "true", tok.text)) {
                    bool_val = true;
                }

                return try self.init_trace_val(try self.init_value(.{ .Bool = bool_val }, allocator), allocator);
            },
            lex.TokenTypes.lsquarebracket, lex.TokenTypes.lsquiglybracket => {
                try self.lexer.step_back(1);
                return try self.parse_value(tok, allocator);
            },
            else => {
                return null;
            }
        }
    }

    fn parse_value(self: *@This(), token: lex.Token, allocator: std.mem.Allocator) !*ctx.ZqlTrace {
        var tok = token;

        if (tok.type == lex.TokenTypes.eof) {
            return try self.init_trace_err(try std.fmt.allocPrint(allocator, "Expected value at {}:{} but got EOF!", .{tok.line, tok.col}), allocator);
        }

        if (tok.type == lex.TokenTypes.lsquarebracket) {
            var value_array = std.ArrayList(*types.Value).init(allocator);

            while (true) {
                tok = try self.lexer.parse_token();
                if (tok.type == lex.TokenTypes.rsquarebracket) {
                    break;
                } else if (tok.type == lex.TokenTypes.comma) {
                    continue;
                } else if (tok.type == lex.TokenTypes.eof) {
                    for (value_array.items) |item| {
                        types.dispose(item, allocator);
                    }
                    value_array.deinit();
                    return try self.init_trace_err(try std.fmt.allocPrint(allocator, "Expected , or ] at {}:{} but got EOF!", .{tok.line, tok.col}), allocator);
                }

                var array_val = try self.parse_primitive_value(tok, allocator);

                if (array_val == null) {
                    for (value_array.items) |item| {
                        types.dispose(item, allocator);
                    }
                    value_array.deinit();
                    return try self.init_trace_err(try std.fmt.allocPrint(allocator, "Expected value at {}:{} but got {} instead!", .{tok.line, tok.col, tok.type}), allocator);
                }
                
                if (array_val.?.err) |_| {
                    return array_val.?;
                }

                if (array_val == null) {
                    for (value_array.items) |item| {
                        types.dispose(item, allocator);
                    }
                    value_array.deinit();

                    return try self.init_trace_err(try std.fmt.allocPrint(allocator, "Expected value at {}:{} but got EOF!", .{tok.line, tok.col}), allocator);
                }

                try value_array.append(array_val.?.value.?);
            }

            return try self.init_trace_val(try self.init_value(.{ .Array = value_array }, allocator), allocator);
        } else if (tok.type == lex.TokenTypes.lsquiglybracket) {
            var obj = try collection.Collection.init(allocator);

            while (true) {
                tok = try self.lexer.parse_token();
                if (tok.type == lex.TokenTypes.rsquiglybracket) {
                    break;
                }

                if (tok.type != lex.TokenTypes.string and
                    tok.type != lex.TokenTypes.identifier) {
                    obj.deinit(allocator);
                    return try self.init_trace_err(try std.fmt.allocPrint(allocator, "Expected String or Identifier but got {} at {}:{}!", .{tok.type, tok.line, tok.col}), allocator);
                }

                var obj_key = try utils.strdup(tok.text, allocator);
                defer allocator.free(obj_key);

                tok = try self.lexer.parse_token();

                var obj_value: ?*ctx.ZqlTrace = null;

                if (tok.type == lex.TokenTypes.colon) {
                    tok = try self.lexer.parse_token();
                    obj_value = try self.parse_primitive_value(tok, allocator);
                }   else {
                    obj_value = try self.parse_primitive_value(tok, allocator);
                }

                if (obj_value == null) {
                    obj.deinit(allocator);
                    return try self.init_trace_err(try std.fmt.allocPrint(allocator, "Expected value at {}:{} but got {} instead!", .{tok.line, tok.col, tok.type}), allocator);
                }

                if (obj_value.?.err) |_| {
                    return obj_value.?;
                }
                try obj.add(obj_key, obj_value.?.value.?, allocator);

                tok = try self.lexer.parse_token();
                if (tok.type != lex.TokenTypes.comma) {
                    try self.lexer.step_back(@intCast(tok.text.len));
                    if (tok.type == lex.TokenTypes.string) {
                        try self.lexer.step_back(2);
                    }
                }
            }

            return try self.init_trace_val(try self.init_value(.{ .Collection = obj }, allocator), allocator);
        }

        var val = try self.parse_primitive_value(tok, allocator);

        if (val != null) {
            if (val.?.err) |_| {
                return val.?;
            }

            return val.?;
        }

        return try self.init_trace_err(try std.fmt.allocPrint(allocator, "Expected value at {}:{} but got {} instead!", .{tok.line, tok.col, tok.type}), allocator);
    }
};
