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

	Parser parser(db, R"(get ahoj[0])");

	std::vector<Context> parsed = parser.parse();

	for (auto& ctx : parsed) {
		std::string error = ctx.get_error();
		if (error.length() > 0) {
			fprintf(stderr, "%s\n", error.c_str());
			continue;
		}

		ctx.execute(nullptr);
	}
	return 0;
}
