#include <cstdio>
#include <memory>
#include <optional>

#include <logger.hpp>
#include <accounts.hpp>
#include <types.hpp>
#include <zql/ctx.hpp>

using ZeonDB::Accounts::Permission;
using ZeonDB::Types::Type;
using ZeonDB::Types::Value;

const static std::string HELP_MSG = R"(help: auth (subcommand)
get <key> (of <user>) -- get your permissions at <key> or from <user>
set <key> <perm> (to <user>) -- set <perm> at <key> to yourself or to <user>
promote <user> -- allow user to manage accounts
demote <user> -- disallow user to manage accounts

key syntax: key@branch
perm syntax: {can_write: bool, can_read: bool})";

std::shared_ptr<Value> perm_to_val(const Permission& perm) {
	auto value = Value::new_collection();
	value->v.c.add("can_read", Value::new_bool(perm.can_read));
	value->v.c.add("can_write", Value::new_bool(perm.can_write));
	value->v.c.add("can_manage", Value::new_bool(perm.can_manage));

	return value;
}

std::optional<Permission> val_to_perm(const std::shared_ptr<Value>& val) {
	Permission perm;

	auto can_read = val->v.c.get("can_read");
	auto can_write = val->v.c.get("can_write");

	if (can_read == nullptr) return {};
	if (can_write == nullptr) return {};

	perm.can_read = can_read->v.b;
	perm.can_write = can_write->v.b;
	perm.can_manage = true;

	return perm;
}

void get_perms(ZeonDB::ZQL::Context* ctx) {
	auto key = ctx->get_arg(1);
	if (ctx->get_arg(0)->v.s.compare("get") != 0 ) {
		ctx->error = HELP_MSG;
		return;
	}

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

void set_perms(ZeonDB::ZQL::Context *ctx) {
	auto key = ctx->get_arg(1);
	auto value = ctx->get_arg(2);
	std::optional<Permission> perm = val_to_perm(value);

	std::string user = ctx->get_user();
	auto perms = ctx->get_perm("$");

	if (!perms.can_manage) {
		LOG_W("User \"%s\" tried to set permissions!", user.c_str());
		ctx->error = "Permissions denied, cannot manage!";
		return;
	}

	if (!perm.has_value()) {
		LOG_W("User \"%s\" tried to set permissions, but are incorrect!", user.c_str());
		ctx->error = "Permission are not complete!";
		return;
	}

	LOG_V("User \"%s\" is settings perms at \"%s\"", user.c_str(), key->v.s.c_str());

	auto current = ctx->get_db();

	if (key->v.s.compare("$") == 0) {
		current->v.c.assign_perm(user, "$", perm.value());
		return;
	}

	std::string s = "";
	while ((s = key->v.s.next(".")).length() > 0) {
		if (!key->v.s.peek(".")) {
			if (current->v.c.has_perms(user, s)) {
				perms = current->v.c.get_perms(user, s);
			}

			current->v.c.assign_perm(user, s, perm.value());
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
		case 3:
			set_perms(ctx);
			break;
		default:
			ctx->error = HELP_MSG;
	}
}
