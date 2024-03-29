#include <cstdio>

#include <types.hpp>
#include <zql/ctx.hpp>

using ZeonDB::Types::Type;
using ZeonDB::Types::ManagedValue;

const static std::string HELP_MSG=R"(help: branches (subcommand)
branches get <key> -- get versions of <key>
branches merge <key> <b1> <b2> -- merge branch <b2> into <b1> at <key>

key syntax: key[index])";

void merge_branches(ZeonDB::ZQL::Context* ctx) {
	auto key = ctx->get_arg(1);
	auto v_target = ctx->get_arg(2);
	auto v_from = ctx->get_arg(3);

	std::string user = ctx->get_user();
	auto perms = ctx->get_perm("$");

    auto* acc = ctx->get_account(user);
    if (acc && acc->special) {
        ctx->error = "Dummy can only create account!";
        return;
    }

	if (!perms.can_read) {
		ctx->error = "Permissions deniend, unable to read!";
		return;
	}

	if (key->v.s.compare("$") == 0) {
		ctx->error = "You cannot merge branches on the root!";
		return;
	}

	auto current = ctx->get_db();
	std::string s = "";

	while ((s = key->v.s.next(".")).length() > 0) {
		if (!key->v.s.peek(".")) {
			if (current->v.c.has_perms(user, s)) {
				perms = current->v.c.get_perms(user, s);
			}

			if (!perms.can_read) {
				ctx->error = "Permissions deniend, unable to read!";
				return;
			}

			if (!perms.can_write) {
				ctx->error = "Permissions denied, unable to write!";
				return;
			}

			std::string s_t = s + "@" + v_target->v.s;
			std::string s_f = s + "@" + v_from->v.s;

			if (!current->v.c.has(s)) {
				ctx->error = "Value " + s + " was not found!";
				return;
			}

			if (!current->v.c.has(s_t)) {
				ctx->error = "Branch " + v_target->v.s +" was not found!";
				return;
			}

			if (!current->v.c.has(s_f)) {
				ctx->error = "Branch " + v_from->v.s +" was not found!";
				return;
			}

			if (current->t != Type::Collection) {
				ctx->error = "Cannot perform version merge on key " + s + " as it is not a Collection!";
				return;
			}

			auto opts = ctx->get_options();

			auto& target = current->v.c.get_ref(s_t);
			auto& from = current->v.c.get_ref(s_f);
			std::string mode = (*opts)["merge_mode"].v.s;

			if (mode.compare("swap") == 0) {
				target.swap(from);
			} else if (mode.compare("overwrite") == 0) {
				current->v.c.add(s_t, current->v.c.get(s_f));
				current->v.c.del(s_f);
			} else if (mode.compare("overwrite_partial") == 0) {
				if (target->t != Type::Collection) {
					ctx->error = "Value at branch " + v_from->v.s + " is not a collection!";
					return;
				}

				if (from->t != Type::Collection) {
					ctx->error = "Value at branch " + v_from->v.s + " is not a collection!";
					return;
				}

				from->v.c.iter([&target](ZeonDB::Utils::String k, ManagedValue v) {
					target->v.c.add(k, v);
				}, "default");

				current->v.c.del(s_f);
			} else if (mode.compare("no_overwrite") == 0) {
				if (target->t != Type::Collection) {
					ctx->error = "Value at branch " + v_from->v.s + " is not a collection!";
					return;
				}

				if (from->t != Type::Collection) {
					ctx->error = "Value at branch " + v_from->v.s + " is not a collection!";
					return;
				}

				from->v.c.iter([&target](ZeonDB::Utils::String k, ManagedValue v) {
					auto val = target->v.c.get(k);
					if (val == nullptr) {
						target->v.c.add(k, v);
					}
				}, "default");
			} else {
				ctx->error = "No such merge mode " + mode + "!";
			}
			break;
		}

		auto val = current->v.c.get(s);
		if (val != nullptr) {
			if (current->v.c.has_perms(user, s)) {
				perms = current->v.c.get_perms(user, s);
			}

			if (!perms.can_read) {
				ctx->error = "Permissions deniend, unable to read!";
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

void get_branches(ZeonDB::ZQL::Context* ctx) {
	auto key = ctx->get_arg(1);

	std::string user = ctx->get_user();
	auto perms = ctx->get_perm("$");

    auto* acc = ctx->get_account(user);
    if (acc && acc->special) {
        ctx->error = "Dummy can only create account!";
        return;
    }

	if (!perms.can_read) {
		ctx->error = "Permissions deniend, unable to read!";
		return;
	}

	if (key->v.s.compare("$") == 0) {
		ctx->error = "You cannot get branches from the root!";
		return;
	}

	auto current = ctx->get_db();
	std::string s = "";
	while ((s = key->v.s.next(".")).length() > 0) {
		if (!key->v.s.peek(".")) {
			if (current->v.c.has_perms(user, s)) {
				perms = current->v.c.get_perms(user, s);
			}

			if (!perms.can_read) {
				ctx->error = "Permissions deniend, unable to read!";
				return;
			}

			auto vers = current->v.c.get_versions(s);
			auto arr = ZeonDB::Types::Value::new_array();

			for (const auto& str : vers) {
				arr->v.a.push_back(ZeonDB::Types::Value::new_string(str));
			}

			*ctx->temporary_buffer = arr;
			break;
		}

		auto val = current->v.c.get(s);
		if (val != nullptr) {
			if (current->v.c.has_perms(user, s)) {
				perms = current->v.c.get_perms(user, s);
			}

			if (!perms.can_read) {
				ctx->error = "Permissions deniend, unable to read!";
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

void branches(ZeonDB::ZQL::Context* ctx) {
	size_t arg_count = ctx->arg_count();
	switch (arg_count) {
		case 2:
		{
			auto subcmd = ctx->get_arg(0);
			if (subcmd->v.s.compare("get") == 0) {
				get_branches(ctx);
			} else {
				ctx->error = HELP_MSG;
			}
			break;
		}
		case 4:
		{
			auto subcmd = ctx->get_arg(0);
			if (subcmd->v.s.compare("merge") == 0) {
				merge_branches(ctx);
			} else {
				ctx->error = HELP_MSG;
			}
			break;
		}
		default:
			ctx->error = HELP_MSG;
	}
}
