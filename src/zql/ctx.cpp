#include <string>
#include <memory>

#include <accounts.hpp>
#include <types.hpp>
#include <zql/ctx.hpp>

namespace ZeonDB::ZQL {
	void Context::set_user(std::string username) {
		this->user = username;
	}

	std::string Context::get_user() {
		return this->user;
	}

	void Context::add_arg(ZqlTrace trace) {
		this->args.push_back(trace);
	}

	std::shared_ptr<ZeonDB::Types::Value> Context::get_arg(size_t index) {
		if (index >= this->args.size()) return nullptr;
		return this->args[index].value;
	}

	void Context::set_options(std::map<std::string, ZeonDB::Types::ManagedValue>* opts) {
		this->options = opts;
	}

	std::map<std::string, ZeonDB::Types::ManagedValue>* Context::get_options() {
		return this->options;
	}

	ZeonDB::Accounts::AccountManager* Context::get_account_manager() {
		return this->amgr;
	}

	ZeonDB::TemplateStore *Context::get_template_store() {
		return this->templ_store;
	}

	std::string Context::get_arg_error(size_t index) {
		if (index >= this->args.size()) return "";
		return this->args[index].error;
	}

	ZeonDB::Accounts::Permission Context::get_perm(std::string key) {
		return this->db->v.c.get_perms(this->user, key);
	}

	std::shared_ptr<ZeonDB::Types::Value> Context::get_db() {
		return this->db;
	}

	size_t Context::arg_count() {
		return this->args.size();
	}

	void Context::set_function(ZqlFunction fn) {
		this->fn = fn;
	}

	void Context::execute(std::shared_ptr<ZeonDB::Types::Value>* buffer) {
		this->temporary_buffer = buffer;

		if (this->fn == nullptr) {
			this->error = "Function not set!";
			return;
		}

		this->fn(this);
	}
}
