#pragma once

#include <string>

namespace ZeonDB::Utils {
	class String: public std::string {
		private:
			size_t iter_pos;
		public:
			String() : std::string(), iter_pos(0) {}
			String(const char* s) : std::string(s), iter_pos(0) {}
			String(std::string s) : std::string(s), iter_pos(0) {}

			std::string next(std::string);
			bool peek(std::string);
			bool contains(std::string);
			void reset_iter();
	};
}
