#pragma once

#include <string>

namespace ZeonDB::ZQL {
	enum class TokenTypes {
		eof = 'E',
		illegal = '?',
		identifier = 'I',
		string = 'S',
		integer = 'N',
		floating = 'F',
		boolean = 'B',
		colon = ':',
		semicolon = ';',
		comma = ',',
		dot = '.',
		dollar = '$',
		at = '@',
		lsquarebracket = '[',
		rsquarebracket = ']',
		lsquiglybracket = '{',
		rsquiglybracket = '}'
	};

	struct Token {
		TokenTypes type;
		size_t line;
		size_t col;
		size_t len;
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
			Token tokenize_string(char);
			Token parse_token();
	};
}
