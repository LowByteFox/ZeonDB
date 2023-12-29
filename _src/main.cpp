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

	memcpy(acc.password, out, SHA256_DIGEST_LENGTH);

	db.register_account("theo", acc);
	db.assign_perm("theo", "$", perm);

	db.run();
	return 0;
}
