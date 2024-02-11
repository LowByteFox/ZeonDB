#include <zql/ctx.hpp>
#include <types.hpp>
#include <memory>

using ZeonDB::Types::ManagedValue;
using ZeonDB::Types::Value;
using ZeonDB::Types::Type;

const static std::string HELP_MSG = R"(help: array (subcommand)
push <key> <value> -- push <value> at the end of array at <key>
insert <key> <index> <value> -- insert <value> at <index> of <key>
erase <key> <index> -- remove value at <index> of <key>
length <key> -- get size of array at <key>

key syntax: key@branch[index])";

void get_length(ZeonDB::ZQL::Context* ctx) {
	auto key = ctx->get_arg(1);

	std::string user = ctx->get_user();

    auto* acc = ctx->get_account(user);
    if (acc && acc->special) {
        ctx->error = "Dummy can only create account!";
        return;
    }

	auto perms = ctx->get_perm("$");

	if (!perms.can_read) {
		ctx->error = "Permissions denied, cannot read!";
		return;
	}

	auto current = ctx->get_db();

	if (key->v.s.compare("$") == 0) {
        ctx->error = "$ is never an array!";
		return;
	}

	std::string s = "";
	while ((s = key->v.s.next(".")).length() > 0) {
		if (!key->v.s.peek(".")) {
			if (current->v.c.has_perms(user, s)) {
				perms = current->v.c.get_perms(user, s);
			}

            if (!perms.can_read) {
                ctx->error = "Permissions denied, cannot read!";
                return;
            }

            auto val = current->v.c.get(s);
            if (val == nullptr) {
                ctx->error = "Array expected at key " + s;
                return;
            }

            if (val->t != Type::Array) {
                ctx->error = "Array expected at key " + s;
                return;
            }

			*ctx->temporary_buffer = Value::new_int(val->v.a.size());
			break;
		}

		auto val = current->v.c.get(s);
		if (val != nullptr) {
			if (current->v.c.has_perms(user, s)) {
				perms = current->v.c.get_perms(user, s);
			}

            if (!perms.can_read) {
                ctx->error = "Permissions denied, cannot read!";
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

void manage_item(ZeonDB::ZQL::Context* ctx, bool not_erase) {
	auto key = ctx->get_arg(1);
    bool insert = ctx->arg_count() == 4;

	std::string user = ctx->get_user();

    auto* acc = ctx->get_account(user);
    if (acc && acc->special) {
        ctx->error = "Dummy can only create account!";
        return;
    }

	auto perms = ctx->get_perm("$");

	if (!perms.can_write) {
		ctx->error = "Permissions denied, cannot write!";
		return;
	}

	auto current = ctx->get_db();

	if (key->v.s.compare("$") == 0) {
        ctx->error = "$ is never an array!";
		return;
	}

	std::string s = "";
	while ((s = key->v.s.next(".")).length() > 0) {
		if (!key->v.s.peek(".")) {
			if (current->v.c.has_perms(user, s)) {
				perms = current->v.c.get_perms(user, s);
			}

            if (!perms.can_write) {
                ctx->error = "Permissions denied, cannot write!";
                return;
            }

            auto val = current->v.c.get(s);
            if (val == nullptr) {
                ctx->error = "Array expected at key " + s;
                return;
            }

            if (val->t != Type::Array) {
                ctx->error = "Array expected at key " + s;
                return;
            }

            if (!not_erase) {
                auto index = ctx->get_arg(2);
                val->v.a.erase(val->v.a.begin() + index->v.i);
                break;
            }

            if (insert) {
                auto index = ctx->get_arg(2);
                auto value = ctx->get_arg(3);
                val->v.a.insert(val->v.a.begin() + index->v.i, value);
                break;
            }

            auto value = ctx->get_arg(2);
            val->v.a.push_back(value);

			break;
		}

		auto val = current->v.c.get(s);
		if (val != nullptr) {
			if (current->v.c.has_perms(user, s)) {
				perms = current->v.c.get_perms(user, s);
			}

            if (!perms.can_write) {
                ctx->error = "Permissions denied, cannot write!";
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

void array(ZeonDB::ZQL::Context* ctx) {
	size_t arg_count = ctx->arg_count();
	switch (arg_count) {
		case 2:
		{
			auto subcmd = ctx->get_arg(0);
			if (subcmd->v.s.compare("length") == 0) {
				get_length(ctx);
            } else {
				ctx->error = HELP_MSG;
			}
			break;
		}
		case 3:
        {
			auto subcmd = ctx->get_arg(0);
            if (subcmd->v.s.compare("push") == 0) {
			    manage_item(ctx, true);
            } else if (subcmd->v.s.compare("erase") == 0) {
                manage_item(ctx, false);
            } else {
                ctx->error = HELP_MSG;
            }
			break;
        }
		case 4:
		{
			auto subcmd = ctx->get_arg(0);
			if (subcmd->v.s.compare("insert") == 0) {
			    manage_item(ctx, true);
			} else {
				ctx->error = HELP_MSG;
			}
			break;
		}
		default:
			ctx->error = HELP_MSG;
	}
}
