#pragma once

#include <string>
#include <memory>
#include <utils/string.hpp>

namespace ZeonDB {
	namespace Types {
		enum class FormatType;

		enum class Type;

		struct Value;
	}

	class Link {
		private:
			ZeonDB::Utils::String target;
			std::shared_ptr<Types::Value> root;

		public:
			void set_target(std::string);
			std::string get_target();
			void set_root(std::shared_ptr<Types::Value>);

			std::shared_ptr<Types::Value> follow(std::string user);
	};
}
