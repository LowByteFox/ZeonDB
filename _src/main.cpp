#include <cstdio>
#include <string>
#include <vector>
#include <memory>

#include <collection.hpp>
#include <types.hpp>
#include <zql/parser.hpp>
#include <zql/ctx.hpp>

using ZeonDB::Collection;
using ZeonDB::Types::FormatType;
using ZeonDB::ZQL::Parser;
using ZeonDB::ZQL::Context;

int main() {
	auto db = std::make_shared<Collection>();

	Parser parser(db, R"(set ahoj cau; get xd)");

	std::vector<Context> parsed = parser.parse();

	for (auto& ctx : parsed) {
		size_t arg_count = ctx.arg_count();
		for (int i = 0; i < arg_count; i++) {
			auto arg = ctx.get_arg(i);
			if (arg == nullptr) continue;
			printf("%s\n", arg->stringify(FormatType::JSON).c_str());
		}
	}
	return 0;
}
