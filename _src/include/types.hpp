#pragma once

#include <cstdio>
#include <cstdint>
#include <string>
#include <memory>
#include <vector>

#include <utils/string.hpp>
#include <collection.hpp>

namespace ZeonDB::Types {
	enum class FormatType {
		ZQL,
		JSON
	};

	enum class Type {
		Array,
		String,
		Int,
		Float,
		Bool,
		Collection,
	};

	struct Value {
		Type t;
		struct {
			std::vector<std::shared_ptr<Value>> a;
			ZeonDB::Utils::String s;
			int64_t i;
			double f;
			bool b;
			ZeonDB::Collection c;
		} v;

		static std::shared_ptr<Value> new_array();
		static std::shared_ptr<Value> new_string(std::string);
		static std::shared_ptr<Value> new_int(int64_t);
		static std::shared_ptr<Value> new_float(double);
		static std::shared_ptr<Value> new_bool(bool);
		static std::shared_ptr<Value> new_collection();

		void array_append(std::shared_ptr<Value>);
		std::string stringify(FormatType fmtType, std::string);
		std::string stringify_array(FormatType, std::string);
	};
}