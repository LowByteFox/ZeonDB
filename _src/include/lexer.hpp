#pragma once

#include <string>

namespace ZeonDB::ZQL {
	enum class {
		eof,
		illegal,
		identifier,
		string,
		integer,
		floating,
		boolean,
		colon,
		semicolon,
		comma,
		lsquarebracket,
		rsquarebracket,
		lsquiglybracket,
		rsquiglybracket
	} TokenTypes;

	struct Token {
		TokenTypes type;
		size_t len;
		size_t col;
		size_t line;
	};

	class Lexer {
		private:
			std::string code;
			size_t pos;
			size_t len;
			size_t col;
			size_t line;
		public:
			Lexer(std::string text) : code(text), pos(0), len(text.length()), col(0), line(0) {}
			char read_char();
			void step_back(size_t);
			void skip_blank();
			void skip_comment();
			Token tokenize_identifier();
			Token tokenize_number();
			Token tokenize_string();
			Token parse_token();
	};
}
