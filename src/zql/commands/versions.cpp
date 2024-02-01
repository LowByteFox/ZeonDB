#include <cstdio>

#include <types.hpp>
#include <zql/ctx.hpp>

using ZeonDB::Types::Type;

void get_versions(ZeonDB::ZQL::Context* ctx) {
	auto key = ctx->get_arg(0);

	std::string user = ctx->get_user();
	auto perms = ctx->get_perm("$");

	if (!perms.can_read) {
		ctx->error = "Permissions deniend, unable to read!";
		return;
	}

	if (key->v.s.compare("$") == 0) {
		*ctx->temporary_buffer = ctx->get_db();
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

void versions(ZeonDB::ZQL::Context* ctx) {
	size_t arg_count = ctx->arg_count();
	switch (arg_count) {
		case 1:
			get_versions(ctx);
			break;
		default:
			ctx->error = R"(help: versions (local) <key>
versions <key> -- get versions of <key>
versions local <key> -- get versions of <key> from local buffer

key syntax: key[index]
)";
	}
}
