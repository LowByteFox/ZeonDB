#include <zql/ctx.hpp>

void get_template(ZeonDB::ZQL::Context* ctx) {
	auto name = ctx->get_arg(1);

	auto templ = ctx->get_template_store();
	*ctx->temporary_buffer = templ->create(name->v.s);
}

void template_cmd(ZeonDB::ZQL::Context* ctx) {
	size_t arg_count = ctx->arg_count();
	switch (arg_count) {
		case 2:
			get_template(ctx);
			break;
		default:
			ctx->error = R"(help: template (subcommand)
get <name> -- print template declaration under name <name>
create <name> <key> -- create teplate from <name> at <key>
set <name> <template> -- declare template under name <name>

template syntax: { key: value, key2 value2 ...}
key -> specifies key of that template
value -> specifies type and default value)";
	}
}
