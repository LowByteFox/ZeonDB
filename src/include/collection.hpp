#pragma once

#include <string>
#include <map>
#include <memory>
#include <functional>

#include <accounts.hpp>

namespace ZeonDB::Types {
	enum class FormatType;

	enum class Type;

	struct Value;
}

namespace ZeonDB {
	class Collection {
		private:
			std::map<std::string, std::shared_ptr<Types::Value>> db;
			std::map<std::string, Accounts::Permission> perms;

		public:
			void assign_perm(std::string, std::string, Accounts::Permission);
			bool has_perms(std::string, std::string);
			Accounts::Permission get_perms(std::string, std::string);
			void add(std::string, std::shared_ptr<Types::Value>);
			std::shared_ptr<Types::Value> get(std::string);
			void iter(std::function<void(std::string, std::shared_ptr<Types::Value>)>);

			std::string stringify(Types::FormatType, std::string);
	};
}
