#include <link.hpp>
#include <logger.hpp>

#include <algorithm>
#include <string>
#include <memory>
#include <fstream>
#include <types.hpp>

namespace ZeonDB {
	void Link::set_target(std::string target) {
		this->target = target;
	}

	std::string Link::get_target() {
		return this->target;
	}

	void Link::set_root(std::shared_ptr<Types::Value> root, std::string path) {
		this->root = root;
		this->root_path = path;
	}

	std::shared_ptr<Types::Value> Link::follow(std::string user, Types::RecursionProtector* protector) {
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
				if (std::find(protector->begin(), protector->end(), val) != protector->end()) {
					return nullptr;
				}
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

	void Link::serialize(std::fstream& stream) {
		size_t len = this->root_path.length();
		stream.write(reinterpret_cast<char*>(&len), sizeof(size_t));

		if (len > 0) {
			stream.write(this->root_path.data(), len);
		}

		len = this->target.length();
		stream.write(reinterpret_cast<char*>(&len), sizeof(size_t));
		stream.write(this->target.data(), this->target.length());
	}
}
