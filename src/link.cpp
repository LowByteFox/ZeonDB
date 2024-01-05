#include <link.hpp>

#include <string>
#include <memory>
#include <types.hpp>

namespace ZeonDB {
	void Link::set_target(std::string target) {
		this->target = target;
	}

	std::string Link::get_target() {
		return this->target;
	}

	void Link::set_root(std::shared_ptr<Types::Value> root) {
		this->root = root;
	}

	std::shared_ptr<Types::Value> Link::follow(std::string user) {
		auto current = this->root;

		auto perms = this->root->v.c.get_perms(user, "$");

		std::string s = "";
		while ((s = this->target.next(".")).length() > 0) {
			if (!this->target.peek(".")) {
				if (current->v.c.has_perms(user, s)) {
					perms = current->v.c.get_perms(user, s);
				}

				if (!perms.can_read) break;

				auto val = current->v.c.get(s);

				return val;
			}

			auto val = current->v.c.get(s);
			if (val != nullptr) {
				if (current->v.c.has_perms(user, s)) {
					perms = current->v.c.get_perms(user, s);
				}

				if (!perms.can_read) {
					break;
				}

				if (val->t != Types::Type::Collection) {
					break;
				}

				current = val;
				continue;
			}
			break;
		}
		return nullptr;
	}
}
