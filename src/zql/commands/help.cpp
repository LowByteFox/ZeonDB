#include <zql/ctx.hpp>

void help(ZeonDB::ZQL::Context* ctx) {
	ctx->error = R"(help: List of available commands
help set get delete
array link auth template
branches options)";
}
