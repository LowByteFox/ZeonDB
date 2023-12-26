#include <string>
#include <vector>
#include <memory>

#include <types.hpp>
#include <zql/ctx.hpp>
#include <zql/parser.hpp>

using ZeonDB::Types::Value;

namespace ZeonDB::ZQL {
	ZqlTrace Parser::parse_primitive_value(Token tok) {
		std::shared_ptr<Value> val = nullptr;
		std::string error = "";
		switch (tok.type) {
			case TokenTypes::identifier:
			case TokenTypes::string:
				val = Value::new_string(this->code.substr(tok.col, tok.len));
				break;
			case TokenTypes::integer:
				val = Value::new_int(std::stoi(this->code.substr(tok.col, tok.len)));
				break;
			case TokenTypes::floating:
				val = Value::new_float(std::stof(this->code.substr(tok.col, tok.len)));
				break;
			case TokenTypes::boolean:
			{
				bool bool_val = false;

				std::string str = this->code.substr(tok.col, tok.len);
				if (str.compare("true")) {
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
		}

		return this->parse_primitive_value(tok);
	}

	std::vector<Context> Parser::parse() {
		std::vector<Context> ctxs;

		Token tok = this->lexer.parse_token();

		if (tok.type != TokenTypes::identifier) {
			Context ctx(this->db, "Expected identifier at " + std::to_string(tok.line) + ":" + std::to_string(tok.col));
			ctxs.push_back(ctx);
			return ctxs;
		}

		while (tok.type != TokenTypes::eof) {
			if (tok.type != TokenTypes::identifier) {
				Context ctx(this->db, "Expected identifier at " + std::to_string(tok.line) + ":" + std::to_string(tok.col));
				ctxs.push_back(ctx);
				return ctxs;
			} else {
				Context ctx(this->db);
				// TODO: set function
				while (true) {
					tok = this->lexer.parse_token();
					if (tok.type == TokenTypes::eof or tok.type == TokenTypes::semicolon) break;

					ZqlTrace arg = this->parse_value(tok);
					ctx.add_arg(arg);
					if (arg.error.length() > 0) {
						break;
					}
				}

				ctxs.push_back(ctx);
			}
			tok = this->lexer.parse_token();
		}
		return ctxs;
	}
}
