#pragma once

#include <string>
#include <map>
#include <unordered_map>
#include <wy.hpp>
#include <memory>
#include <functional>
#include <fstream>

#include <accounts.hpp>
#include <utils/string.hpp>
#include <utils/key_processor.hpp>

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
			void add(ZeonDB::Utils::Key, std::shared_ptr<Types::Value>);
			bool del(ZeonDB::Utils::Key);
			bool has(ZeonDB::Utils::Key);
			std::shared_ptr<Types::Value> get(ZeonDB::Utils::Key);
			std::shared_ptr<Types::Value>& get_ref(ZeonDB::Utils::Key);
			void iter(std::function<void(ZeonDB::Utils::String, std::shared_ptr<Types::Value>)>, std::string);
			std::vector<ZeonDB::Utils::String> get_versions(ZeonDB::Utils::Key);

			std::string stringify(Types::FormatType, std::string, ZeonDB::Types::RecursionProtector*);
			void serialize(std::fstream&);
	};
}
