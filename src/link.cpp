#include <link.hpp>
#include <logger.hpp>

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

		if (this->root->v.c.has_perms(user, "$")) {
			auto perms = this->root->v.c.get_perms(user, "$");
			if (!perms.can_read) return nullptr;
		}

		std::string s = "";
		while ((s = this->target.next(".")).length() > 0) {
			if (!this->target.peek(".")) {
				if (current->v.c.has_perms(user, "$")) {
					auto perms = this->root->v.c.get_perms(user, "$");
					if (!perms.can_read) return nullptr;
				}

				this->target.reset_iter();
				auto val = current->v.c.get(s);
				return val;
			}

			auto val = current->v.c.get(s);
			if (val != nullptr) {
				if (current->v.c.has_perms(user, "$")) {
					auto perms = this->root->v.c.get_perms(user, "$");
					if (!perms.can_read) return nullptr;
				}

				if (val->t != Types::Type::Collection) {
					break;
				}

				current = val;
				continue;
			}
			break;
		}
		this->target.reset_iter();
		return nullptr;
	}
}
