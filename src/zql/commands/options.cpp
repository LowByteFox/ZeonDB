#include <zql/ctx.hpp>

void options(ZeonDB::ZQL::Context* ctx) {
	ctx->error = R"(help: options (subcommand)
options print -- print out options for current session
options get <option> -- get value of specific <option>
options set <option> <value> -- set <value> at <option>)";
}
