#include <cstdio>
#include <string>
#include <vector>
#include <memory>

#include <accounts.hpp>
#include <db.hpp>
#include <ssl.hpp>

#include <openssl/sha.h>

int main() {
	ZeonDB::DB db;

	unsigned char out[SHA256_DIGEST_LENGTH];

	ZeonDB::SSL::SHA256("paris", out);

	ZeonDB::Accounts::Account acc;
	std::memcpy(acc.password, out, SHA256_DIGEST_LENGTH);

	db.register_account("theo", acc);

	return 0;
}
