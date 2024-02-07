#pragma once

#include <cstdio>
#include <cstdint>
#include <string>
#include <memory>
#include <vector>
#include <fstream>
#include <sstream>

#include <link.hpp>
#include <utils/string.hpp>
#include <collection.hpp>

namespace ZeonDB {
	struct SerializationContext;
}

namespace ZeonDB::Types {
	enum class FormatType {
		ZQL,
		JSON
	};

	enum class Type {
		Array = 0,
		String,
		Int,
		Float,
		Bool,
		Collection,
		Link,
	};

	struct Value;

	using RecursionProtector = std::vector<std::shared_ptr<Value>>;
	
	struct Value {
		Type t;
		struct {
			std::vector<std::shared_ptr<Value>> a;
			ZeonDB::Utils::String s;
			int64_t i;
			double f;
			bool b;
			ZeonDB::Collection c;
			ZeonDB::Link l;
		} v;

		static std::shared_ptr<Value> new_array();
		static std::shared_ptr<Value> new_string(std::string);
		static std::shared_ptr<Value> new_int(int64_t);
		static std::shared_ptr<Value> new_float(double);
		static std::shared_ptr<Value> new_bool(bool);
		static std::shared_ptr<Value> new_collection();
		static std::shared_ptr<Value> new_link(std::string);

		void stringify(FormatType fmtType, std::string, std::stringstream&);
		void _stringify(FormatType fmtType, std::string, RecursionProtector*, std::stringstream&);
		void _stringify_array(FormatType, std::string, RecursionProtector*, std::stringstream&);

		void serialize(std::fstream&);
		void serialize_array(std::fstream&);

		void unserialize(ZeonDB::SerializationContext);
		void unserialize_array(ZeonDB::SerializationContext);
	};

	using ManagedValue = std::shared_ptr<Value>;
}
