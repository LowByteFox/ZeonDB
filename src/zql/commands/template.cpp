#include <string>
#include <memory>
#include <types.hpp>
#include <zql/ctx.hpp>
#include <templates.hpp>
#include <logger.hpp>

using ZeonDB::Types::Type;
using ZeonDB::Types::Value;

const static std::string HELP_MSG = R"(help: template (subcommand)
get <name> -- print template declaration under name <name>
set <name> <key> -- create collection from template <name> at <key>
create <name> <template> -- create template under name <name>

template syntax: { key: value, key2 value2 ...}
key -> specifies key of that template
value -> specifies type and default value)";

void get_template(ZeonDB::ZQL::Context* ctx) {
	auto name = ctx->get_arg(1);
	std::string user = ctx->get_user();

	LOG_I("User \"%s\" accessed template \"%s\"", user.c_str(), name->v.s.c_str());

	auto templ = ctx->get_template_store();
	*ctx->temporary_buffer = templ->create(name->v.s);
}

void set_template(ZeonDB::ZQL::Context* ctx) {
	auto name = ctx->get_arg(1);
	auto key = ctx->get_arg(2);

	std::string user = ctx->get_user();
	auto perms = ctx->get_perm("$");

	if (!perms.can_write) {
		LOG_W("User \"%s\" tried to create template \"%s\" at \"%s\"", user.c_str(), name->v.s.c_str(), key->v.s.c_str());
		ctx->error = "Permissions denied, unable to write!";
		return;
	}

	if (key->v.s.compare("$") == 0) {
		ctx->error = "Cannot create template named \"$\"!";
		return;
	}

	auto templ = ctx->get_template_store();
	auto current = ctx->get_db();
	std::string s = "";
	while ((s = key->v.s.next(".")).length() > 0) {
		if (!key->v.s.peek(".")) {
			if (current->v.c.has_perms(user, s)) {
				perms = current->v.c.get_perms(user, s);
			}

			if (!perms.can_write) {
				ctx->error = "Permissions deniend, unable to write!";
				return;
			}

			auto val = current->v.c.get(s);

			if (val != nullptr) {
				ctx->error = "Value at key \"" + key->v.s + "\" already exists!";
				return;
			}
			current->v.c.add(s, templ->create(name->v.s));
			break;
		}

		auto val = current->v.c.get(s);
		if (val != nullptr) {
			if (current->v.c.has_perms(user, s)) {
				perms = current->v.c.get_perms(user, s);
			}

			if (!perms.can_write) {
				ctx->error = "Permissions deniend, unable to write!";
				return;
			}

			if (val->t != Type::Collection) {
				ctx->error = "Collection expected at key " + s;
				return;
			}

			current = val;
			continue;
		}

		ctx->error = "No such key \"" + key->v.s + "\"!";
		break;
	}
}

void create_template(ZeonDB::ZQL::Context* ctx) {
	auto name = ctx->get_arg(1);
	auto value = ctx->get_arg(2);

	std::string user = ctx->get_user();
	auto perms = ctx->get_perm("$");

	if (!perms.can_manage) {
		LOG_W("User \"%s\" tried to make new template \"%s\"", user.c_str(), name->v.s.c_str());
		ctx->error = "Permissions denied, cannot manage!";
		return;
	}

	ZeonDB::Template templat;

	auto template_man = ctx->get_template_store();
	value->v.c.iter([&templat](std::string key, std::shared_ptr<Value> val) {
			templat.add(key, val); 
	});

	template_man->add(name->v.s, templat);
}

void template_cmd(ZeonDB::ZQL::Context* ctx) {
	size_t arg_count = ctx->arg_count();
	switch (arg_count) {
		case 2:
			get_template(ctx);
			break;
		case 3:
		{
			auto subcmd = ctx->get_arg(0);
			if (subcmd->v.s.compare("create") == 0) {
				create_template(ctx);
			} else if (subcmd->v.s.compare("set") == 0) {
				set_template(ctx);
			} else {
				ctx->error = HELP_MSG;
			}
			break;
		}
		default:
			ctx->error = HELP_MSG;
	}
}
