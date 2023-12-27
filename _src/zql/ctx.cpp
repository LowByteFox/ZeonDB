#include <string>
#include <memory>

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
	std::string Context::get_arg_error(size_t index) {
		if (index >= this->args.size()) return "";
		return this->args[index].error;
	}

	size_t Context::arg_count() {
		return this->args.size();
	}

	void Context::set_function(ZqlFunction fn) {
		this->fn = fn;
	}

	void Context::execute(std::shared_ptr<ZeonDB::Types::Value> buffer) {
		if (buffer != nullptr) 
			this->temporary_buffer = buffer;

		if (this->fn == nullptr) {
			this->error = "Function not set!";
			return;
		}

		this->fn(this);
	}
}
