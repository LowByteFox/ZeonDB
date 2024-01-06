#pragma once

#include <string>
#include <map>
#include <unordered_map>
#include <wy.hpp>
#include <memory>
#include <functional>

#include <accounts.hpp>

namespace ZeonDB {
	namespace Types {
		enum class FormatType;

		enum class Type;

		struct Value;
	}

	class Collection {
		private:
			std::unordered_map<std::string, std::shared_ptr<Types::Value>, wy::hash<std::string>> db;
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
