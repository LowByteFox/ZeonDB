#pragma once

#include <string>
#include <utility>
#include <utils/string.hpp>

namespace ZeonDB::Utils {
	struct Key {
		std::string key;
		std::string version;
		std::pair<int, int> array_range;

		Key(String);
		Key(std::string key): Key(String(key)) {}
		Key(const char *key): Key(String(key)) {}
	};
}
