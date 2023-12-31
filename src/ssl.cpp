#include <cstring>

#include <ssl.hpp>

#include <openssl/sha.h>

namespace ZeonDB::SSL {
	void SHA256(const char *input, unsigned char *output) {
		SHA256_CTX sha256;
		SHA256_Init(&sha256);
		SHA256_Update(&sha256, input, strlen(input));
	    SHA256_Final(output, &sha256);
	}
}
