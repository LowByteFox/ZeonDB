#include <string>
#include <memory>
#include <types.hpp>
#include <zql/ctx.hpp>
#include <templates.hpp>
#include <logger.hpp>

using ZeonDB::Types::Type;
using ZeonDB::Types::Value;

void link_data(ZeonDB::ZQL::Context* ctx) {
	auto from = ctx->get_arg(0);
	auto to = ctx->get_arg(1);

	std::string user = ctx->get_user();
	auto perms = ctx->get_perm("$");

	if (!perms.can_write) {
		LOG_W("User \"%s\" tried to link data from \"%s\" to \"%s\"", user.c_str(), from->v.s.c_str(), to->v.s.c_str());
		ctx->error = "Permissions denied, unable to write!";
		return;
	}

	if (to->v.s.compare("$") == 0) {
		ctx->error = "Cannot create link to \"$\"!";
		return;
	}

	auto current = ctx->get_db();
	std::string s = "";
	while ((s = from->v.s.next(".")).length() > 0) {
		if (!from->v.s.peek(".")) {
			if (current->v.c.has_perms(user, s)) {
				perms = current->v.c.get_perms(user, s);
			}

			if (!perms.can_write) {
				ctx->error = "Permissions deniend, unable to write!";
				return;
			}

			auto lnk = Value::new_link(to->v.s);
			lnk->v.l.set_root(ctx->get_db());

			if (to->v.s.length() > 2 && to->v.s[0] == '$' && to->v.s[1] == '.') {
				lnk->v.l.set_target(to->v.s.substr(2));
				lnk->v.l.set_root(current);
			}

			current->v.c.add(s, lnk);
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

		ctx->error = "No such key \"" + from->v.s + "\"!";
		break;
	}
}


void link_cmd(ZeonDB::ZQL::Context* ctx) {
	size_t arg_count = ctx->arg_count();
	switch (arg_count) {
		case 2:
			link_data(ctx);
			break;
		default:
			ctx->error = R"(help: link <to> <from>
$ in <from> means that deepest collection of <to> will be used as root for the link

example:
  set hello.world hey
  link hello.svet $.world -- don't forget .
  get hello -- {world: hey, svet: hey})";
	}
}
