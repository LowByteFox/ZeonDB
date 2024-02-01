#include <zql/ctx.hpp>

void del_casual(ZeonDB::ZQL::Context* ctx) {
	auto key = ctx->get_arg(0);

	std::string user = ctx->get_user();
	auto perms = ctx->get_perm("$");

	if (!perms.can_read) {
		ctx->error = "Permissions deniend, unable to write!";
		return;
	}

	if (key->v.s.compare("$") == 0) {
		ctx->error = "You cannot delete the root!";
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

			bool ret = current->v.c.del(s);

			if (!ret) {
				ctx->error = "No such key \"" + key->v.s + "\"!";
				return;
			}
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

			current = val;
			continue;
		}

		ctx->error = "No such key \"" + key->v.s + "\"!";
		break;
	}
}

void del(ZeonDB::ZQL::Context* ctx) {
	size_t arg_count = ctx->arg_count();
	switch (arg_count) {
		case 1:
			del_casual(ctx);
			break;
		default:
			ctx->error = R"(help: delete (local) <key>
delete <key> -- delete value at <key>
delete local <key> -- delete value at key <key> in local buffer

key syntax: key@branch[index]
- the ..range is optional)";
	}
}
