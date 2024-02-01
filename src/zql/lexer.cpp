#include <logger.hpp>
#include <zql/lexer.hpp>

#include <string>
#include <cctype>
#include <cstring>

namespace ZeonDB::ZQL {
	char Lexer::read_char() {
		if (this->pos - 1 == this->len) return 0;
		char current = this->code[this->pos];
		this->pos++;
		this->col++;
		return current;
	}

	void Lexer::step_back(size_t count) {
		this->pos -= count;
		this->col -= count;
	}

	void Lexer::skip_blank() {
		char current = this->read_char();

		while (current == ' ' || current == '\t' || current == '\n') {
			if (current == '\n') {
				this->col = 0;
				this->line++;
			}
			current = this->read_char();
		}

		this->step_back(1);
	}

	void Lexer::skip_comment() {
		if (this->read_char() != '-') {
			this->step_back(1);
			return;
		}

		char current = this->read_char();

		while (current != '\n' && current != 0) {
			current = this->read_char();
		}

		this->col = 0;
		this->line += 1;
	}

	Token Lexer::tokenize_identifier() {
		Token tok;
		tok.type = TokenTypes::identifier;
		tok.col = this->pos;
		tok.line = this->line;
		char current = this->read_char();

		while (isdigit(current) || isalpha(current) ||
				current == '_' || current == '$' || current == ':' ||
				current == '@' || current == '[' || current == ']') {
			current = this->read_char();
		}

		this->step_back(1);
		tok.len = this->pos - tok.col;

		std::string txt = this->code.substr(tok.col, tok.len);

		if (txt.compare("true") == 0) {
			tok.type = TokenTypes::boolean;
		} else if (txt.compare("false") == 0)  {
			tok.type = TokenTypes::boolean;
		}

		return tok;
	}

	Token Lexer::tokenize_number() {
		Token tok;
		tok.type = TokenTypes::integer;
		tok.col = this->pos;
		tok.line = this->line;

		bool is_float = false;
		char current = this->read_char();

		while (isdigit(current) || current == '.') {
			current = this->read_char();
			if (current == '.' && !is_float) {
				is_float = true;
				continue;
			}
			if (current == '.' && is_float) break;
		}

		this->step_back(1);
		tok.len = this->pos - tok.col;

		if (is_float) {
			tok.type = TokenTypes::floating;
		}

		return tok;
	}

	Token Lexer::tokenize_string(char to_end) {
		Token tok;
		tok.type = TokenTypes::string;
		tok.line = this->line;
		tok.col = this->pos;

		char current = this->read_char();
		while (true) {
			char next = this->read_char();
			if (current == 0) break;
			if (current == '\\' && next == to_end) {
				current = this->read_char();
				continue;
			}
			this->step_back(1);
			if (current == to_end) break;
			current = this->read_char();
		}

		tok.len = this->pos - tok.col - 1;

		return tok;
	}

	Token Lexer::parse_token() {
		this->skip_blank();

		char tok = this->read_char();

		if (tok == 0) {
			return (Token) {
				.type = TokenTypes::eof,
					.line = this->line,
					.col = this->col,
					.len = 0,
			};
		}

		switch (tok) {
			case '"':
			case '\'':
				return this->tokenize_string(tok);
				break;
			case ':':
				return (Token) {
					.type = TokenTypes::colon,
						.line = this->line,
						.col = this->col - 1,
						.len = 1,
				};
				break;
			case ';':
				return (Token) {
					.type = TokenTypes::semicolon,
						.line = this->line,
						.col = this->col - 1,
						.len = 1,
				};
				break;
			case ',':
				return (Token) {
					.type = TokenTypes::comma,
						.line = this->line,
						.col = this->col - 1,
						.len = 1,
				};
				break;
			case '[':
				return (Token) {
					.type = TokenTypes::lsquarebracket,
						.line = this->line,
						.col = this->col - 1,
						.len = 1,
				};
				break;
			case ']':
				return (Token) {
					.type = TokenTypes::rsquarebracket,
						.line = this->line,
						.col = this->col - 1,
						.len = 1,
				};
				break;
			case '{':
				return (Token) {
					.type = TokenTypes::lsquiglybracket,
						.line = this->line,
						.col = this->col - 1,
						.len = 1,
				};
				break;
			case '}':
				return (Token) {
					.type = TokenTypes::rsquiglybracket,
						.line = this->line,
						.col = this->col - 1,
						.len = 1,
				};
				break;
			case '-':
				this->skip_comment();
				return this->parse_token();
		}

		if (isalpha(tok) || tok == '_' || tok == '$') {
			this->step_back(1);
			return this->tokenize_identifier();
		} else if (isdigit(tok)) {
			this->step_back(1);
			return this->tokenize_number();
		} else {
			return (Token) {
				.type = TokenTypes::illegal,
					.line = this->line,
					.col = this->col,
					.len = 0,
			};
		}
	}
}
