#include <cstdio>
#include <string>

#include <types.hpp>
#include <zql/ctx.hpp>

using ZeonDB::Types::Type;
using ZeonDB::Types::Value;

void set_casual(ZeonDB::ZQL::Context* ctx) {
	auto key = ctx->get_arg(0);
	auto value = ctx->get_arg(1);

	std::string user = ctx->get_user();
	auto perms = ctx->get_perm("$");

    auto* acc = ctx->get_account(user);
    if (acc && acc->special) {
        ctx->error = "Dummy can only create account!";
        return;
    }

	if (!perms.can_write) {
		ctx->error = "Permissions deniend, unable to write!";
		return;
	}

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

			current->v.c.add(s, value);
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

			val->t = Type::Collection;

			current = val;
			continue;
		}
		auto v = Value::new_collection();
		current->v.c.add(s, v);
		current = v;
	}
}

void set(ZeonDB::ZQL::Context* ctx) {
	size_t arg_count = ctx->arg_count();
	switch (arg_count) {
		case 2:
			set_casual(ctx);
			break;
		default:
			ctx->error = R"(help: set (local) <key> (<value>)(from (local) <key2>)
set <key> <value> -- set <value> at specific <key>

key syntax: key@branch[index])";
	}
}
