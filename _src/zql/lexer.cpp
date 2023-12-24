#include <zql/lexer.hpp>

#include <string>
#include <cctype>
#include <cstring>

namespace ZeonDB::ZQL {
	char Lexer::read_char() {
		if (this->pos - 1 == this->len) return 0;
		char current = this->text[this->pos];
		this->pos++;
		this->col++;
		return current;
	}

	void Lexer::step_back(size_t count) {
		if (this->pos - count < 0) return;
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

		if (current == 0) return;
		this->step_back(1);
	}

	void Lexer::skip_comment() {
		if (this->read_char() != '-') {
			this->step_back(1);
			return;
		}

        char current = this->read_char();

        while (current != '\n') {
            current = self.read_char();
        }

        this->col = 0;
        self->line += 1;
	}

	Token Lexer::tokenize_identifier() {
		Token tok;
		tok.type = TokenTypes::identifier;
		tok.col = this->col;
        tok.line = this->line;

		char current = this->read_char();

		while (isdigit(current) || isalpha(current) || current == '_' || current == '$' || current == '.' || current == '@') {
			current = this->read_char();
		}

		this->step_back(1);
		tok.len = this->col - tok.col;

		if (this->text.find("true", tok.col) != std::string::npos) {
			tok.type = TokenTypes::boolean;
		} else if (this->text.find("false", tok.col) != std::string::npos)  {
			tok.type = TokenTypes::boolean;
		}

		return tok;
	}

	Token Lexer::tokenize_number() {

	}
}
