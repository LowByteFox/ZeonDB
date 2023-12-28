#include <cstdio>
#include <string>

#include <zql/ctx.hpp>

void set_casual(ZeonDB::ZQL::Context* ctx) {
	auto key = ctx->get_arg(0);
	auto value = ctx->get_arg(1);

	std::string user = ctx->get_user();
	auto perms = ctx->get_perm("$");

	if (!perms.can_write) {
		ctx->error = "Permissions deniend, unable to write!";
		return;
	}

	auto current = ctx->get_db();
}

void set(ZeonDB::ZQL::Context* ctx) {
	size_t arg_count = ctx->arg_count();
	switch (arg_count) {
		case 2:
			set_casual(ctx);
		default:
			ctx->error = R"(help: set (local) <key> (<value>)(from (local) <key2>)
set <key> <value> -- set <value> at specific <key>
set local <key> <value> -- set <value> at specific <key> in local buffer
set local <key> from <key2> -- set value from <key2> at specific <key> in local buffer

key syntax: key@branch[index(..range)])";
	}
}
