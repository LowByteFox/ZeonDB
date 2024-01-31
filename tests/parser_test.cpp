#include <cstdio>
#include <string>
#include <zql2/parser.hpp>
#include <unit_tester.hpp>

using namespace ZeonDB::ZQL;

std::string test1() {
	Parser parser("set [7, 4, { ahoj : cau }]");

	auto out = parser.parse();
	printf("\n%s\n", out.stringify().c_str());

	return out.stringify();
}

std::string test2() {
	Parser parser("set $.world.ahoj@cau[0].ale[3..4]. 0");

	auto out = parser.parse();
	printf("\n%s\n", out.stringify().c_str());

	return out.stringify();
}

int main() {
	match(test1, {"set [7,4,{ahoj:cau}]"});
	match(test2, {"set $.world.ahoj@cau[0].ale[3..4]. 0"});
	return 0;
}
