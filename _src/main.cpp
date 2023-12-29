#include <cstdio>
#include <string>
#include <vector>
#include <memory>

#include <accounts.hpp>
#include <db.hpp>
#include <ssl.hpp>
#include <zql/ctx.hpp>

#include <openssl/sha.h>

#ifndef __ORDER_LITTLE_ENDIAN__
#error "__ORDER_LITTLE_ENDIAN__ must be defined, use different compiler!"
#endif

int main() {
	ZeonDB::DB db;

	unsigned char out[SHA256_DIGEST_LENGTH];

	ZeonDB::SSL::SHA256("paris", out);

	ZeonDB::Accounts::Account acc;
	ZeonDB::Accounts::Permission perm = {
		.can_write = true,
		.can_read = true,
		.can_manage = true,
	};

	std::memcpy(acc.password, out, SHA256_DIGEST_LENGTH);

	db.register_account("theo", acc);
	db.assign_perm("theo", "$", perm);

	ZeonDB::ZQL::ZqlTrace trace = db.execute(R"(set ahoj.nice.yay cau; get ahoj.nice.yay)", "theo");

	if (trace.error.length() > 0) {
		fprintf(stderr, "Error: %s\n", trace.error.c_str());
	} else if (trace.value != nullptr) {
		printf("Value: %s\n", trace.value->stringify(ZeonDB::Types::FormatType::JSON).c_str());
	} else {
		printf("Got null!\n");
	}

	return 0;
}
