#include <cstdint>
#include <memory>
#include <vector>
#include <string>
#include <fstream>
#include <sstream>
#include <cstdint>

#include <types.hpp>
#include <collection.hpp>
#include <serializator.hpp>

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

	void Value::_stringify_array(FormatType fmtType, std::string username, RecursionProtector* protector, std::stringstream& res) {
		res << "[";

		for (auto it = this->v.a.begin(); it != this->v.a.end(); it++) {
			(*it)->_stringify(fmtType, username, protector, res);

			if (std::next(it) != this->v.a.end()) {
				if (fmtType == FormatType::JSON) {
					res << ", ";
				} else {
					res << " ";
				}
			}
		}

		res << "]";
	}

	void Value::stringify(FormatType fmtType, std::string username, std::stringstream& res) {
		RecursionProtector protector;
		this->_stringify(fmtType, username, &protector, res);
	}

	void Value::_stringify(FormatType fmtType, std::string username, RecursionProtector* protector, std::stringstream& res) {
		switch (this->t) {
			case Type::Array:
				this->_stringify_array(fmtType, username, protector, res);
				break;
			case Type::String:
				if (this->v.s.find(' ') != std::string::npos || fmtType == FormatType::JSON) {
					res << "\"" + this->v.s + "\"";
				} else {
					res << this->v.s;
				}
				break;
			case Type::Int:
				res << this->v.i;
				break;
			case Type::Float:
				res << this->v.f;
				break;
			case Type::Bool:
				res << (this->v.b ? "true" : "false");
				break;
			case Type::Collection:
				this->v.c.stringify(fmtType, username, protector, res);
				break;
			case Type::Link:
			{
				auto val = this->v.l.follow(username, protector);
				if (val == nullptr) {
					res << "\"\"";
					return;
				}

				protector->push_back(val);
				val->_stringify(fmtType, username, protector, res);
				protector->pop_back();
			}
		}
	}


	void Value::serialize_array(std::fstream& stream) {
		size_t len = this->v.a.size();
		stream.write(reinterpret_cast<char*>(&len), sizeof(size_t));

		for (const auto& item : this->v.a) {
			stream.write(reinterpret_cast<char*>(&item->t), sizeof(Type));
			item->serialize(stream);
		}
	}

	void Value::serialize(std::fstream& stream) {
		switch (this->t) {
			case Type::String:
			{
				size_t len = this->v.s.length();
				stream.write(reinterpret_cast<char*>(&len), sizeof(size_t));
				stream.write(this->v.s.data(), this->v.s.length());
				break;
			}
			case Type::Int:
				stream.write(reinterpret_cast<char*>(&this->v.i), sizeof(int64_t));
				break;
			case Type::Float:
				stream.write(reinterpret_cast<char*>(&this->v.f), sizeof(double));
				break;
			case Type::Bool:
				stream.write(reinterpret_cast<char*>(&this->v.b), sizeof(bool));
				break;
			case Type::Array:
				this->serialize_array(stream);
				break;
			case Type::Link:
				this->v.l.serialize(stream);
				break;
			case Type::Collection:
				this->v.c.serialize(stream);
				break;
		}
	}

	void Value::unserialize_array(SerializationContext ctx) {
		size_t len = 0;
		ctx.stream.read(reinterpret_cast<char*>(&len), sizeof(size_t));

		for (int i = 0; i < len; i++) {
			auto obj = std::make_shared<Value>();
			ctx.stream.read(reinterpret_cast<char*>(&obj->t), sizeof(Type));
			obj->unserialize(ctx);
			this->v.a.push_back(obj);
		}
	}

	void Value::unserialize(SerializationContext ctx) {
		switch (this->t) {
			case Type::String:
			{
				size_t len = 0;
				ctx.stream.read(reinterpret_cast<char*>(&len), sizeof(size_t));
				this->v.s = std::string(len, 0);
				ctx.stream.read(this->v.s.data(), len);
				break;
			}
			case Type::Int:
				ctx.stream.read(reinterpret_cast<char*>(&this->v.i), sizeof(int64_t));
				break;
			case Type::Float:
				ctx.stream.read(reinterpret_cast<char*>(&this->v.f), sizeof(double));
				break;
			case Type::Bool:
				ctx.stream.read(reinterpret_cast<char*>(&this->v.b), sizeof(bool));
				break;
			case Type::Array:
				this->unserialize_array(ctx);
				break;
			case Type::Link:
				this->v.l.unserialize(ctx);
				break;
			case Type::Collection:
				this->v.c.unserialize(ctx);
				break;
		}
	}
}
