#include <string>
#include <vector>
#include <memory>

#include <logger.hpp>
#include <types.hpp>
#include <collection.hpp>
#include <zql/ctx.hpp>
#include <zql/parser.hpp>

using ZeonDB::Types::Value;

#define EXTRN(N) extern void N(ZeonDB::ZQL::Context *ctx);
#define FN(N) {#N, N}

EXTRN(help);
EXTRN(get);
EXTRN(del);
EXTRN(set);
EXTRN(auth);
EXTRN(template_cmd);
EXTRN(link_cmd);
EXTRN(link_cmd);
EXTRN(branches);
EXTRN(options);
EXTRN(array);

std::map<std::string, ZeonDB::ZQL::ZqlFunction> commands {
	FN(help),
	FN(branches),
	FN(get),
	FN(array),
	{"delete", del},
	FN(set),
	FN(auth),
	{"template", template_cmd},
	{"link", link_cmd},
	FN(options),
};

std::string substr(std::string_view& view, size_t start, size_t len) {
    return std::string({view.begin() + start, view.begin() + start + len});
}

namespace ZeonDB::ZQL {
	ZqlTrace Parser::parse_primitive_value(Token tok) {
		std::shared_ptr<Value> val = nullptr;
		std::string error = "";
		switch (tok.type) {
			case TokenTypes::identifier:
			case TokenTypes::string:
				val = Value::new_string(substr(this->code, tok.col, tok.len));
				break;
			case TokenTypes::integer:
				val = Value::new_int(std::stoi(substr(this->code, tok.col, tok.len)));
				break;
			case TokenTypes::floating:
				val = Value::new_float(std::stof(substr(this->code, tok.col, tok.len)));
				break;
			case TokenTypes::boolean:
			{
				bool bool_val = false;

				std::string str = substr(this->code, tok.col, tok.len);
				if (str.compare("true") == 0) {
					bool_val = true;
				}

				val = Value::new_bool(bool_val);
				break;
			}
			case TokenTypes::lsquarebracket:
			case TokenTypes::lsquiglybracket:
			{
				ZqlTrace trace = this->parse_value(tok);
				if (trace.value)
					val = trace.value;
				else if (trace.error.length() > 0)
					error = trace.error;
				break;
			}
			default:
				val = nullptr;
				error = "Invalid token at parse_primitive_value " + std::to_string(tok.line) + ":" + std::to_string(tok.col);
		}

		return (ZqlTrace) {
			.value = val,
			.error = error
		};
	}

	ZqlTrace Parser::parse_value(Token tok) {
		if (tok.type == TokenTypes::eof) {
			return (ZqlTrace) {
				.value = nullptr,
				.error = "Expected value at " + std::to_string(tok.line) + ":" + std::to_string(tok.col) + " but got EOF!",
			};
		}

		if (tok.type == TokenTypes::lsquarebracket) {
			LOG_D("Parsing array", nullptr);
			std::vector<std::shared_ptr<Value>> values;

			while (true) {
				tok = this->lexer.parse_token();
				if (tok.type == TokenTypes::rsquarebracket) break;
				else if (tok.type == TokenTypes::comma) continue;
				else if (tok.type == TokenTypes::eof)
					return (ZqlTrace) {
						.value = nullptr,
						.error = "Expected , or ] at " + std::to_string(tok.line) + ":" + std::to_string(tok.col)
					};

				auto val = this->parse_primitive_value(tok);

				if (val.error.length() > 0) {
					return val;
				}

				values.push_back(val.value);
			}

			auto array = Value::new_array();
			array->v.a = values;
			return (ZqlTrace) {
				.value = array,
				.error = ""
			};
		} else if (tok.type == TokenTypes::lsquiglybracket) {
			LOG_D("Parsing collection", nullptr);
			Collection object;

			bool key_parsed = false;
			std::string key;

			while (true) {
				tok = this->lexer.parse_token();
				if (key_parsed == false) {
					if (tok.type == TokenTypes::rsquiglybracket) break;
					else if (tok.type == TokenTypes::comma) continue;
					else if (tok.type == TokenTypes::eof)
						return (ZqlTrace) {
							.value = nullptr,
							.error = "Expected , or } at " + std::to_string(tok.line) + ":" + std::to_string(tok.col)
						};
				} else {
					if (tok.type == TokenTypes::colon) continue;
					else if (tok.type == TokenTypes::rsquiglybracket || tok.type == TokenTypes::eof)
						return (ZqlTrace) {
							.value = nullptr,
							.error = "Expected value at " + std::to_string(tok.line) + ":" + std::to_string(tok.col)
						};
				}

				if (key_parsed == false) {
					key = this->code.substr(tok.col, tok.len);
					key_parsed = true;
					continue;
				}

				auto val = this->parse_primitive_value(tok);

				if (val.error.length() > 0) {
					return val;
				}

				object.add(key, val.value);
				key_parsed = false;
			}

			auto obj = Value::new_collection();
			obj->v.c = object;
			return (ZqlTrace) {
				.value = obj,
				.error = ""
			};
		}

		return this->parse_primitive_value(tok);
	}

	std::vector<Context> Parser::parse() {
		std::vector<Context> ctxs;

		Token tok = this->lexer.parse_token();

		LOG_D("Got token %s %d", substr(this->code, tok.col, tok.len).c_str(), tok.type);
		if (tok.type != TokenTypes::identifier) {
			Context ctx(this->db, "Expected identifier at " + std::to_string(tok.line) + ":" + std::to_string(tok.col));
			ctxs.push_back(ctx);
			return ctxs;
		}

		while (tok.type != TokenTypes::eof && tok.type != TokenTypes::illegal) {
			if (tok.type != TokenTypes::identifier) {
				Context ctx(this->db, "Expected identifier at " + std::to_string(tok.line) + ":" + std::to_string(tok.col));
				ctxs.push_back(ctx);
				return ctxs;
			} else {
				Context ctx(this->db);
				std::string fn_name = substr(this->code, tok.col, tok.len);
				if (!commands.contains(fn_name)) {
					Context ctx(this->db, "Unknown command at " + std::to_string(tok.line) + ":" + std::to_string(tok.col));
					ctxs.push_back(ctx);
					return ctxs;
				}

				ctx.set_function(commands[fn_name]);
				while (true) {
					tok = this->lexer.parse_token();
					if (tok.type == TokenTypes::eof or tok.type == TokenTypes::semicolon) break;

					LOG_D("Parsing token %s", substr(this->code, tok.col, tok.len).c_str());
					ZqlTrace arg = this->parse_value(tok);
					ctx.add_arg(arg);
					if (arg.error.length() > 0) {
						LOG_D("Context recieved an error!", nullptr);
						ctx.error = arg.error;
						break;
					}
				}

				LOG_D("Context parsed successfully!", nullptr);
				ctxs.push_back(ctx);
			}
			tok = this->lexer.parse_token();
		}
		if (tok.type == TokenTypes::illegal) {
			Context ctx(this->db, "Invalid token");
			ctxs.push_back(ctx);
		}

		return ctxs;
	}
}
