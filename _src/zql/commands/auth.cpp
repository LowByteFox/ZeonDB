#include <cstdio>
#include <memory>

#include <logger.hpp>
#include <accounts.hpp>
#include <types.hpp>
#include <zql/ctx.hpp>

using ZeonDB::Accounts::Permission;
using ZeonDB::Types::Type;
using ZeonDB::Types::Value;

std::shared_ptr<Value> perm_to_val(const Permission& perm) {
	auto value = Value::new_collection();
	value->v.c.add("can_read", Value::new_bool(perm.can_read));
	value->v.c.add("can_write", Value::new_bool(perm.can_write));
	value->v.c.add("can_manage", Value::new_bool(perm.can_manage));

	return value;
}

void get_perms(ZeonDB::ZQL::Context* ctx) {
	auto key = ctx->get_arg(1);

	std::string user = ctx->get_user();
	auto perms = ctx->get_perm("$");

	if (!perms.can_manage) {
		LOG_W("User \"%s\" tried to access permissions!", user.c_str());
		ctx->error = "Permissions denied, cannot manage!";
		return;
	}

	LOG_V("User \"%s\" is accessing perms at \"%s\"", user.c_str(), key->v.s.c_str());

	if (key->v.s.compare("$") == 0) {
		*ctx->temporary_buffer = perm_to_val(perms);
		return;
	}

	auto current = ctx->get_db();
	std::string s = "";
	while ((s = key->v.s.next(".")).length() > 0) {
		if (!key->v.s.peek(".")) {
			if (current->v.c.has_perms(user, s)) {
				perms = current->v.c.get_perms(user, s);
			}

			*ctx->temporary_buffer = perm_to_val(perms);
			break;
		}

		auto val = current->v.c.get(s);
		if (val != nullptr) {
			if (current->v.c.has_perms(user, s)) {
				perms = current->v.c.get_perms(user, s);
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

void auth(ZeonDB::ZQL::Context* ctx) {
	size_t arg_count = ctx->arg_count();
	switch (arg_count) {
		case 2:
			get_perms(ctx);
			break;
		default:
			ctx->error = R"(help: auth (subcommand)
get <key> (of <user>) -- get your permissions at <key> or from <user>
set <key> <perm> (to <user>) -- set <perm> at <key> to yourself or to <user>
promote <user> -- allow user to manage accounts
demote <user> -- disallow user to manage accounts

key syntax: key@branch
perm syntax: {can_write: bool, can_read: bool})";
	}
}
