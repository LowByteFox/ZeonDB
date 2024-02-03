#pragma once

#include <functional>
#include <string>
#include <memory>
#include <vector>

#include <types.hpp>
#include <accounts.hpp>
#include <templates.hpp>

namespace ZeonDB {
	class DB;
}

namespace ZeonDB::ZQL {
	class Context;

	typedef std::function<void(Context*)> ZqlFunction;

	struct ZqlTrace {
		std::shared_ptr<ZeonDB::Types::Value> value;
		std::string error;
	};

	class Context {
		friend class ZeonDB::DB;

		private:
			std::shared_ptr<ZeonDB::Types::Value> db;
			std::map<std::string, ZeonDB::Types::Value>* options;
			ZeonDB::Accounts::AccountManager *amgr;
			ZeonDB::TemplateStore *templ_store;

			std::vector<ZqlTrace> args;
			ZqlFunction fn;
			std::string user;

		public:
			std::shared_ptr<ZeonDB::Types::Value>* temporary_buffer;
			std::string error;

			Context(std::shared_ptr<ZeonDB::Types::Value> collection) : db(collection) {}
			Context(std::shared_ptr<ZeonDB::Types::Value> collection, std::string err) : db(collection), error(err) {}
			void set_options(std::map<std::string, ZeonDB::Types::Value>*);
			std::map<std::string, ZeonDB::Types::Value>* get_options();
			ZeonDB::Accounts::AccountManager *get_account_manager();
			ZeonDB::TemplateStore *get_template_store();
			void set_user(std::string);
			std::string get_user();
			void add_arg(ZqlTrace);
			ZeonDB::Accounts::Permission get_perm(std::string);
			std::shared_ptr<ZeonDB::Types::Value> get_db();
			std::shared_ptr<ZeonDB::Types::Value> get_arg(size_t);
			std::string get_arg_error(size_t index);
			size_t arg_count();
			void set_function(ZqlFunction);
			void execute(std::shared_ptr<ZeonDB::Types::Value>*);
	};
}
