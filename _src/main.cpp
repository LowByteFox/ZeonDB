#include <cstdio>

#include <types.hpp>

int main() {
	auto value = ZeonDB::Types::Value::new_array();

	value->array_append(ZeonDB::Types::Value::new_int(77));
	value->array_append(ZeonDB::Types::Value::new_string("Ahoj"));
	value->array_append(ZeonDB::Types::Value::new_float(3.14));
	value->array_append(ZeonDB::Types::Value::new_bool(true));

	auto arr = ZeonDB::Types::Value::new_array();
	value->array_append(arr);

	arr->array_append(ZeonDB::Types::Value::new_string("Taky test"));

	printf("%s\n", value->stringify(ZeonDB::Types::FormatType::JSON).c_str());
	return 0;
}
