#pragma once

#include <string>
#include <map>
#include <unordered_map>
#include <wy.hpp>
#include <memory>
#include <functional>

#include <accounts.hpp>
#include <utils/string.hpp>

namespace ZeonDB {
	namespace Types {
		enum class FormatType;

		enum class Type;

		struct Value;
	}

	using Map = std::unordered_map<std::string, std::shared_ptr<Types::Value>, wy::hash<std::string>>;

	class Collection {
		private:
			std::map<ZeonDB::Utils::String, Map> db;
			std::map<std::string, Accounts::Permission> perms;
			std::string def_ver = "default";

		public:
			void assign_perm(std::string, std::string, Accounts::Permission);
			bool has_perms(std::string, std::string);
			Accounts::Permission get_perms(std::string, std::string);
			void add(ZeonDB::Utils::String, std::shared_ptr<Types::Value>);
			bool del(ZeonDB::Utils::String);
			std::shared_ptr<Types::Value> get(ZeonDB::Utils::String);
			void iter(std::function<void(ZeonDB::Utils::String, std::shared_ptr<Types::Value>)>);

			std::string stringify(Types::FormatType, std::string, ZeonDB::Types::RecursionProtector*);
	};
}
