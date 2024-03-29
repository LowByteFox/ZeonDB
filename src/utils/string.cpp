#include <utils/string.hpp>

namespace ZeonDB::Utils {
	std::string String::next(std::string delimiter) {
		if (this->iter_pos == std::string::npos) return "";
		size_t current = this->iter_pos;
		size_t end = this->find(delimiter, current);
		if (end == std::string::npos) {
			this->iter_pos = std::string::npos;
			return this->substr(current, this->length() - current);
		} else {
			this->iter_pos = end;
		}
		this->iter_pos += delimiter.length();
		return this->substr(current, this->iter_pos - current - delimiter.length());
	}

	bool String::peek(std::string delimiter) {
		return this->find(delimiter, this->iter_pos - delimiter.size()) != std::string::npos;
	}

	bool String::contains(std::string to_find) {
		return this->find(to_find) != std::string::npos;
	}

	void String::reset_iter() {
		this->iter_pos = 0;
	}
}
