#include <zql/ctx.hpp>
#include <memory>
#include <types.hpp>
#include <logger.hpp>

using ZeonDB::Types::Value;
using ZeonDB::Types::Type;

#include <string>

const static std::string HELP_MSG = R"(help: options (subcommand)
options print -- get options for current session
options get <option> -- get value of specific <option>
options set <option> <value> -- set <value> at <option>)";

void print_opts(ZeonDB::ZQL::Context* ctx) {
	auto obj = Value::new_collection();

	auto opts = ctx->get_options();

	for (const auto [key, value]: *opts) {
		obj->v.c.add(key, std::make_shared<Value>(value));
	}

	*ctx->temporary_buffer = obj;
}

void set_opt(ZeonDB::ZQL::Context* ctx) {
	auto opts = ctx->get_options();
	auto key = ctx->get_arg(1);

	if (!opts->contains(key->v.s)) {
		ctx->error = "No such option " + key->v.s + "!";
		return;
	}

	(*opts)[key->v.s] = *ctx->get_arg(2);
}

void get_opt(ZeonDB::ZQL::Context* ctx) {
	auto opts = ctx->get_options();
	auto key = ctx->get_arg(1);

	if (!opts->contains(key->v.s)) {
		ctx->error = "No such option " + key->v.s + "!";
		return;
	}

	*ctx->temporary_buffer = std::make_shared<Value>((*opts)[key->v.s]);
}

void options(ZeonDB::ZQL::Context* ctx) {
	size_t arg_count = ctx->arg_count();
	switch (arg_count) {
		case 1:
		{
			auto subcmd = ctx->get_arg(0);
			if (subcmd->v.s.compare("print") == 0) {
				print_opts(ctx);
			}  else {
				ctx->error = HELP_MSG;
			}
			break;
		}
		case 2:
		{
			auto subcmd = ctx->get_arg(0);
			if (subcmd->v.s.compare("get") == 0) {
				get_opt(ctx);
			}  else {
				ctx->error = HELP_MSG;
			}
			break;
		}
		case 3:
		{
			auto subcmd = ctx->get_arg(0);
			if (subcmd->v.s.compare("set") == 0) {
				set_opt(ctx);
			}  else {
				ctx->error = HELP_MSG;
			}
			break;
		}
		default:
			ctx->error = HELP_MSG;
	}
}
