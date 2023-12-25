#pragma once

#include <functional>
#include <string>
#include <memory>
#include <vector>

#include <types.hpp>
#include <collection.hpp>

namespace ZeonDB::ZQL {
	class Context;

	typedef std::function<void(Context*)> ZqlFunction;

	struct ZqlTrace {
		std::shared_ptr<ZeonDB::Types::Value> value;
		std::string error;
	};

	class Context {
		private:
			std::shared_ptr<ZeonDB::Collection> db;
			std::vector<ZqlTrace> args;
			ZqlFunction fn;
			std::shared_ptr<ZeonDB::Types::Value> temporary_buffer;
			std::string user;
			std::string error;
		public:
			Context(std::shared_ptr<ZeonDB::Collection> collection) : db(collection) {}
			Context(std::shared_ptr<ZeonDB::Collection> collection, std::string err) : db(collection), error(err) {}
			void set_user(std::string);
			std::string get_user();
			std::string get_error();
			void add_arg(ZqlTrace);
			std::shared_ptr<ZeonDB::Types::Value> get_arg(size_t);
			size_t arg_count();
			void set_function(ZqlFunction);
			void execute(std::shared_ptr<ZeonDB::Types::Value>);
	};
}
