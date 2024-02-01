#include <cstdio>

#include <logger.hpp>
#include <types.hpp>
#include <zql/ctx.hpp>
#include <utils/key_processor.hpp>

using ZeonDB::Types::Type;

void get_casual(ZeonDB::ZQL::Context* ctx) {
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
	ZeonDB::Utils::Key s = "";
	while ((s = key->v.s.next(".")).key.length() > 0) {
		if (!key->v.s.peek(".")) {
			if (current->v.c.has_perms(user, s.key)) {
				perms = current->v.c.get_perms(user, s.key);
			}

			if (!perms.can_read) {
				ctx->error = "Permissions deniend, unable to read!";
				return;
			}

			auto val = current->v.c.get(s);

			if (val == nullptr) {
				ctx->error = "No such key \"" + key->v.s + "\"!";
				return;
			}

			if (val->t == Type::Array) {
				if (s.array_range.first > -1) {
					val = val->v.a[s.array_range.first];
				}
			}

			*ctx->temporary_buffer = val;
			break;
		}

		auto val = current->v.c.get(s);

		if (val != nullptr) {
			if (current->v.c.has_perms(user, s.key)) {
				perms = current->v.c.get_perms(user, s.key);
			}

			if (!perms.can_read) {
				ctx->error = "Permissions deniend, unable to read!";
				return;
			}

			if (val->t == Type::Array) {
				if (s.array_range.first > -1) {
					val = val->v.a[s.array_range.first];
				} else {
					ctx->error = "Array expected index at key " + s.key;
					return;
				}
			}

			if (val->t != Type::Collection) {
				ctx->error = "Collection expected at key " + s.key;
				return;
			}

			current = val;
			continue;
		}

		ctx->error = "No such key \"" + key->v.s + "\"!";
		break;
	}
}

void get(ZeonDB::ZQL::Context* ctx) {
	size_t arg_count = ctx->arg_count();
	switch (arg_count) {
		case 1:
			get_casual(ctx);
			break;
		default:
			ctx->error = R"(help: get (local) <key>
get <key> -- get value of <key> as local buffer
get local <key> -- get value of <key> from local buffer as local buffer

key syntax: key@branch(index..range)
- the ..range is optional)";
	}
}
