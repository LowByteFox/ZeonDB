#include <cstdio>

#include <types.hpp>
#include <collection.hpp>

int main() {
	ZeonDB::Collection db;
	db.add("ahoj", ZeonDB::Types::Value::new_int(77));

	printf("%s\n", db.stringify(ZeonDB::Types::FormatType::JSON).c_str());
	return 0;
}
