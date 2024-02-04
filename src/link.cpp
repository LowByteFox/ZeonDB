#include <link.hpp>
#include <logger.hpp>
#include <uv.h>

#include <algorithm>
#include <string>
#include <memory>
#include <fstream>
#include <types.hpp>

#include <serializator.hpp>

namespace ZeonDB {
	void configure_link(uv_idle_t*);

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

	void Link::unserialize(SerializationContext ctx) {
		size_t len = 0;
		ctx.stream.read(reinterpret_cast<char*>(&len), sizeof(size_t));

		if (len > 0) {
			this->root_path = std::string(len, 0);
			ctx.stream.read(this->root_path.data(), len);
		}

		len = 0;
		ctx.stream.read(reinterpret_cast<char*>(&len), sizeof(size_t));
		this->target = std::string(len, 0);
		ctx.stream.read(this->target.data(), this->target.length());
		this->root = ctx.root;

		uv_idle_t* idle_handle = new uv_idle_t;
		idle_handle->data = this;

		uv_idle_init(uv_default_loop(), idle_handle);
		uv_idle_start(idle_handle, configure_link);
	}

	void configure_link(uv_idle_t* handle) {
		auto link = (Link*) handle->data;

		auto current = link->root;
		std::string s = "";

		while ((s = link->root_path.next(".")).length() > 0) {
			if (!link->root_path.peek(".")) {
				auto val = current->v.c.get(s);
				link->root = val;
				link->root_path.reset_iter();
				break;
			}

			auto val = current->v.c.get(s);
			if (val != nullptr) {
				current = val;
				continue;
			}
			break;
		}

		link->root_path.reset_iter();
		uv_idle_stop(handle);
		delete handle;
	}
}
