#include <cstdio>
#include <string>

#include <zql/lexer.hpp>

using ZeonDB::ZQL::Lexer;
using ZeonDB::ZQL::Token;
using ZeonDB::ZQL::TokenTypes;

int main() {
	std::string str = R"(set ahoj [xd nice] {ahoj {cau hmm}} -- komentar

ano 74 3.14 true false)";
	Lexer lex(str);

	Token tok = lex.parse_token();

	while (tok.type != TokenTypes::eof) {
		printf("%s\n", str.substr(tok.col, tok.len).c_str());
		tok = lex.parse_token();
	}
	return 0;
}
