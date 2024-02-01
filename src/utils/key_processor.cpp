#include <utils/key_processor.hpp>
#include <algorithm>
#include <string>
#include <logger.hpp>

namespace ZeonDB::Utils {
	Key::Key(String key) {
		bool has_version = false;

		this->key = "";

		if (key.contains("@")) {
			this->key = key.next("@");
			this->version = key.next("[");
			has_version = true;
		}

		if (!has_version) {
			this->key = key.next("[");
		}

		this->array_range.first = -1;
		this->array_range.second = -1;

		if (key.contains("[") && key.contains("]")) {
			String ver(key.next("]"));

			this->array_range.first = atoi(ver.next(":").c_str());
			if (ver.contains(":")) {
				this->array_range.second = atoi(ver.next("]").c_str());
			}
		}
	}
}
