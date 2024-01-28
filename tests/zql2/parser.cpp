#include <zql2/parser.hpp>

#include <string>
#include <vector>
#include <utility>

namespace ZeonDB::ZQL {
	std::string AstNode::stringify() const {
		return "";
	}

	void KeyNode::set_version(std::string version) {
		this->version = version;
	}

	std::string KeyNode::get_version() {
		return this->version;
	}

	void KeyNode::set_array_index(size_t index) {
		this->array_bounds.first = index;
	}

	void KeyNode::set_array_range(size_t range) {
		this->array_bounds.second = range;
	}

	std::pair<int, int>& KeyNode::get_array_range() {
		return this->array_bounds;
	}

	size_t KeyNode::get_array_index() {
		return this->array_bounds.first;
	}

	std::string KeyNode::stringify() const {
		std::string str = this->name;

		if (this->version.length() > 0) {
			str += "@";
			str += this->version;
		}

		if (this->array_bounds.first >= 0) {
			if (this->array_bounds.second >= 0) {
				str += "[";
				str += std::to_string(this->array_bounds.first);
				str += "..";
				str += std::to_string(this->array_bounds.second);
				str += "]";
			} else {
				str += "[";
				str += std::to_string(this->array_bounds.first);
				str += "]";
			}
		}
		
		return str;
	}

	std::string CommandKeyNode::stringify() const {
		std::string str = "";
		if (this->size() == 0) {
			str += ".";
		}

		for (const auto& key : (*this)) {
			str += key.stringify();
			str += ".";
		}
		str.pop_back();

		return str;
	}

	ValueTypes CommandValueNode::get_type() {
		return this->value_type;
	}

	void CommandValueNode::set_text(std::string text) {
		this->text = text;
	}

	std::string CommandValueNode::get_text() {
		return this->text;
	}

	std::string CommandValueNode::stringify() const {
		return this->text;
	}

	std::string CommandEvalNode::get_cmd_name() {
		return this->command_name;
	}

	std::string CommandEvalNode::stringify() const {
		std::string str = this->command_name;
		for (const auto& node : (*this)) {
			str += " ";
			str += node->stringify();
		}

		return str;
	}
}
