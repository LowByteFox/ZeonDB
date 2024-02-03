#pragma once

#include <string>
#include <memory>
#include <vector>
#include <fstream>
#include <utils/string.hpp>

namespace ZeonDB {
	namespace Types {
		enum class FormatType;

		enum class Type;

		struct Value;
		using RecursionProtector = std::vector<std::shared_ptr<Value>>;
	}

	class Link {
		private:
			ZeonDB::Utils::String target;
			ZeonDB::Utils::String root_path;
			std::shared_ptr<Types::Value> root;

		public:
			void set_target(std::string);
			std::string get_target();
			void set_root(std::shared_ptr<Types::Value>, std::string);

			std::shared_ptr<Types::Value> follow(std::string user, Types::RecursionProtector*);
			void serialize(std::fstream&);
	};
}
