#include <vector>
#include <functional>
#include <string>
#include <unit_tester.hpp>
#include <zql2/lexer.hpp>

using namespace ZeonDB::ZQL;
using TokTy = TokenTypes;

std::function<std::vector<TokTy>()> fn_gen(std::string code) {
	return [code]() {
		Lexer lex(code);
		Token tok = lex.parse_token();

		std::vector<TokTy> ret;

		while(tok.type != TokTy::eof && tok.type != TokTy::illegal) {
			ret.push_back(tok.type);
			tok = lex.parse_token();
		}

		return ret;
	};
}
int main() {
	match(fn_gen("set $ true"),
	    std::vector<TokTy>({TokTy::identifier, TokTy::dollar, 
	    TokTy::boolean}));

	match(fn_gen("set ahoj[0] lol"),
	    std::vector<TokTy>({TokTy::identifier, TokTy::identifier,
	    TokTy::lsquarebracket, TokTy::integer, TokTy::rsquarebracket,
	    TokTy::identifier}));

	match(fn_gen(R"(set ahoj."lol
	    space"@god.74.1.50.ahoj[0..10]@hm.heh {omg: god})"),
	    std::vector<TokTy>({TokTy::identifier, TokTy::identifier,
	    TokTy::dot, TokTy::string, TokTy::at, TokTy::identifier,
	    TokTy::dot, TokTy::floating, TokTy::dot, TokTy::integer,
	    TokTy::dot, TokTy::identifier, TokTy::lsquarebracket,
	    TokTy::integer, TokTy::dot, TokTy::dot, TokTy::integer,
	    TokTy::rsquarebracket, TokTy::at, TokTy::identifier, TokTy::dot,
	    TokTy::identifier, TokTy::lsquiglybracket, TokTy::identifier,
	    TokTy::colon, TokTy::identifier, TokTy::rsquiglybracket}));
	return 0;
}
