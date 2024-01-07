#include <cstdint>
#include <memory>
#include <vector>
#include <string>

#include <types.hpp>
#include <collection.hpp>

namespace ZeonDB::Types {
	std::shared_ptr<Value> Value::new_array() {
		auto ptr = std::make_shared<Value>();
		ptr->t = Type::Array;
		return ptr;
	}

	std::shared_ptr<Value> Value::new_string(std::string initial_value = "") {
		auto ptr = std::make_shared<Value>();
		ptr->t = Type::String;
		ptr->v.s = initial_value;
		return ptr;
	}

	std::shared_ptr<Value> Value::new_int(int64_t initial_value = 0) {
		auto ptr = std::make_shared<Value>();
		ptr->t = Type::Int;
		ptr->v.i = initial_value;
		return ptr;
	}

	std::shared_ptr<Value> Value::new_float(double initial_value = 0.0) {
		auto ptr = std::make_shared<Value>();
		ptr->t = Type::Float;
		ptr->v.f = initial_value;
		return ptr;
	}

	std::shared_ptr<Value> Value::new_bool(bool initial_value = false) {
		auto ptr = std::make_shared<Value>();
		ptr->t = Type::Bool;
		ptr->v.b = initial_value;
		return ptr;
	}

	std::shared_ptr<Value> Value::new_collection() {
		auto ptr = std::make_shared<Value>();
		ptr->t = Type::Collection;
		return ptr;
	}

	std::shared_ptr<Value> Value::new_link(std::string target) {
		auto ptr = std::make_shared<Value>();
		ptr->t = Type::Link;
		ptr->v.l.set_target(target);
		return ptr;
	}

	std::string Value::_stringify_array(FormatType fmtType, std::string username, RecursionProtector* protector) {
		std::string str = "[";

		for (const auto& item : this->v.a) {
			str += item->_stringify(fmtType, username, protector);
			if (fmtType == FormatType::JSON) {
				str += ", ";
			} else {
				str += " ";
			}
		}

		if (str.length() > 1 && fmtType == FormatType::JSON) {
			str.erase(str.length() - 1, 1);
		}

		if (str.length() > 1) {
			str[str.length() - 1] = ']';
		} else {
			str += "]";
		}

		return str;
	}

	std::string Value::stringify(FormatType fmtType, std::string username) {
		RecursionProtector protector;
		return this->_stringify(fmtType, username, &protector);
	}

	std::string Value::_stringify(FormatType fmtType, std::string username, RecursionProtector* protector) {
		switch (this->t) {
			case Type::Array:
				return this->_stringify_array(fmtType, username, protector);
			case Type::String:
				if (this->v.s.find(' ') != std::string::npos || fmtType == FormatType::JSON) {
					return "\"" + this->v.s + "\"";
				} else {
					return this->v.s;
				}
			case Type::Int:
				return std::to_string(this->v.i);
			case Type::Float:
				return std::to_string(this->v.f);
			case Type::Bool:
				return this->v.b ? "true" : "false";
			case Type::Collection:
				return this->v.c.stringify(fmtType, username, protector);
			case Type::Link:
			{
				auto val = this->v.l.follow(username, protector);
				if (val == nullptr) return "\"\"";

				protector->push_back(val);
				std::string str = val->_stringify(fmtType, username, protector);
				protector->pop_back();
				return str;
			}
			default:
				break;
		}
		return "??";
	}
}
