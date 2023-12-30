#pragma once

#include <memory>
#include <string>

#include <types.hpp>
#include <zql/lexer.hpp>
#include <zql/ctx.hpp>

namespace ZeonDB::ZQL {
	class Context;
	struct ZqlTrace;

	class Parser {
		private:
			std::string code;
			std::shared_ptr<ZeonDB::Types::Value> db;
			Lexer lexer;
			ZqlTrace parse_primitive_value(Token);
			ZqlTrace parse_value(Token); // TODO
		public:
			Parser(std::shared_ptr<ZeonDB::Types::Value> collection, std::string code) : lexer(code) {
				this->code = code;
				this->db = collection;
			}
			std::vector<Context> parse();
	};
}
