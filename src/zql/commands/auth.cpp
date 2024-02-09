#include <cstdio>
#include <cstring>
#include <memory>
#include <optional>

#include <ssl.hpp>
#include <logger.hpp>
#include <accounts.hpp>
#include <types.hpp>
#include <zql/ctx.hpp>

#include <openssl/sha.h>

using ZeonDB::Accounts::Permission;
using ZeonDB::Types::Type;
using ZeonDB::Types::Value;

const static std::string HELP_MSG = R"(help: auth (subcommand)
get <key> (of <user>) -- get your permissions at <key> or from <user>
set <key> <perm> (to <user>) -- set <perm> at <key> to yourself or to <user>
create <user> <pass> <perm> -- create user <user> with password <pass> and default permission <perm>
promote <user> -- allow <user> to manage accounts
demote <user> -- disallow <user> to manage accounts
delete <user> -- delete <user>

key syntax: key@branch
perm syntax: {can_write: bool, can_read: bool})";

std::shared_ptr<Value> perm_to_val(const Permission& perm) {
	auto value = Value::new_collection();
	value->v.c.add("can_read", Value::new_bool(perm.can_read));
	value->v.c.add("can_write", Value::new_bool(perm.can_write));

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
	perm.can_manage = false;

	return perm;
}

void get_perms(ZeonDB::ZQL::Context* ctx, bool other_user) {
	auto key = ctx->get_arg(1);

	std::string user = ctx->get_user();

    auto* acc = ctx->get_account(user);
    if (acc && acc->special) {
        ctx->error = "Dummy can only create account!";
        return;
    }

	auto perms = ctx->get_perm("$");

	if (!perms.can_manage) {
		LOG_W("User \"%s\" tried to access permissions!", user.c_str());
		ctx->error = "Permissions denied, cannot manage!";
		return;
	}

	LOG_V("User \"%s\" is accessing perms at \"%s\"", user.c_str(), key->v.s.c_str());
	auto current = ctx->get_db();

	if (other_user) {
		auto target_user = ctx->get_arg(3); // <user>
		user = target_user->v.s;
		perms = current->v.c.get_perms(user, "$");
	}

	if (key->v.s.compare("$") == 0) {
		*ctx->temporary_buffer = perm_to_val(perms);
		return;
	}

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

void set_perms(ZeonDB::ZQL::Context *ctx, bool other_user) {
	auto key = ctx->get_arg(1);
	auto value = ctx->get_arg(2);
	std::optional<Permission> perm = val_to_perm(value);

	std::string user = ctx->get_user();
	auto perms = ctx->get_perm("$");

    auto* acc = ctx->get_account(user);

    if (acc && acc->special) {
        ctx->error = "dummy can only create account!";
        return;
    }

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

	if (other_user) {
		auto target_user = ctx->get_arg(4); // <user>
		user = target_user->v.s;
	}

	auto current = ctx->get_db();

	if (key->v.s.compare("$") == 0) {
		current->v.c.assign_perm(user, "$", perm.value());
		return;
	}

	std::string s = "";
	while ((s = key->v.s.next(".")).length() > 0) {
		if (!key->v.s.peek(".")) {
			current->v.c.assign_perm(user, s, perm.value());
			break;
		}

		auto val = current->v.c.get(s);
		if (val != nullptr) {
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

void create_user(ZeonDB::ZQL::Context* ctx) {
	auto target_user = ctx->get_arg(1);
	auto pass = ctx->get_arg(2);
	auto default_perm = ctx->get_arg(3);

	std::optional<Permission> perm = val_to_perm(default_perm);

	std::string user = ctx->get_user();
	auto perms = ctx->get_perm("$");

    auto* acc1 = ctx->get_account(user);

	if (!perms.can_manage) {
		LOG_W("User \"%s\" tried to create user!", user.c_str());
		ctx->error = "Permissions denied, cannot manage!";
		return;
	}

	if (!perm.has_value()) {
		LOG_W("User \"%s\" tried to provide permissions, but are incorrect!", user.c_str());
		ctx->error = "Permission are not complete!";
		return;
	}

	Permission perm_val = perm.value();
	perm_val.can_manage = false;

    if (acc1 && acc1->special) {
        perm_val.can_manage = true;
    }

	auto mgr = ctx->get_account_manager();

	unsigned char out[SHA256_DIGEST_LENGTH];

	ZeonDB::SSL::SHA256(pass->v.s.c_str(), out);
	ZeonDB::Accounts::Account acc;
    acc.special = false;

	memcpy(acc.password, out, SHA256_DIGEST_LENGTH);

	mgr->register_account(target_user->v.s, acc);
	ctx->get_db()->v.c.assign_perm(target_user->v.s, "$", perm_val);
}

void manage_user(ZeonDB::ZQL::Context *ctx, bool promote) {
	std::string user = ctx->get_user();
	auto perms = ctx->get_perm("$");

    auto* acc = ctx->get_account(user);
    if (acc && acc->special) {
        ctx->error = "Dummy can only create account!";
        return;
    }

	if (!perms.can_manage) {
		LOG_W("User \"%s\" tried to manage user!", user.c_str());
		ctx->error = "Permissions denied, cannot manage!";
		return;
	}

	auto target_user = ctx->get_arg(1);

	if (target_user->v.s.compare(user) == 0) {
		ctx->error = "You cannot ";
		if (promote) ctx->error += "promote yourself!";
		else ctx->error += "demote yourself!";
		return;
	}

	auto db = ctx->get_db();

	auto perm = db->v.c.get_perms(target_user->v.s, "$");
	perm.can_manage = promote;
	db->v.c.assign_perm(target_user->v.s, "$", perm);
}

void delete_user(ZeonDB::ZQL::Context *ctx) {
	std::string user = ctx->get_user();
	auto perms = ctx->get_perm("$");

    auto* acc = ctx->get_account(user);
    if (acc && acc->special) {
        ctx->error = "Dummy can only create account!";
        return;
    }

	if (!perms.can_manage) {
		LOG_W("User \"%s\" tried to delete user!", user.c_str());
		ctx->error = "Permissions denied, cannot manage!";
		return;
	}

	auto target_user = ctx->get_arg(1);

	if (target_user->v.s.compare(user) == 0) {
		ctx->error = "You cannot delete yourself";
		return;
	}

	auto mgr = ctx->get_account_manager();

    mgr->delete_account(target_user->v.s);
}

void auth(ZeonDB::ZQL::Context* ctx) {
	size_t arg_count = ctx->arg_count();
	switch (arg_count) {
		case 2:
		{
			auto subcmd = ctx->get_arg(0);
			if (subcmd->v.s.compare("get") == 0) {
				get_perms(ctx, false);
			} else if (subcmd->v.s.compare("promote") == 0) {
				manage_user(ctx, true);
			} else if (subcmd->v.s.compare("demote") == 0) {
				manage_user(ctx, false);
			} else if (subcmd->v.s.compare("delete") == 0) {
                delete_user(ctx);
            } else {
				ctx->error = HELP_MSG;
			}
			break;
		}
		case 3:
        {
			auto subcmd = ctx->get_arg(0);
            if (subcmd->v.s.compare("set") == 0) {
			    set_perms(ctx, false);
            } else {
                ctx->error = HELP_MSG;
            }
			break;
        }
		case 4:
		{
			auto subcmd = ctx->get_arg(0);
			if (subcmd->v.s.compare("create") == 0) {
				create_user(ctx);
			} else if (subcmd->v.s.compare("get") == 0) {
				get_perms(ctx, true);
			} else {
				ctx->error = HELP_MSG;
			}
			break;
		}
		case 5:
			set_perms(ctx, true);
			break;
		default:
			ctx->error = HELP_MSG;
	}
}
