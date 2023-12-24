#include <string>
#include <cstring>

#include <accounts.hpp>

#include <openssl/sha.h>

namespace ZeonDB::Accounts {
	void AccountManager::register_account(std::string username, Account account) {
		this->accounts.emplace(username, account);
	}

	bool AccountManager::login(std::string username, unsigned char password[SHA256_DIGEST_LENGTH]) {
		if (this->accounts.contains(username)) {
			Account& account = this->accounts[username];
			return memcmp(password, account.password, SHA256_DIGEST_LENGTH) == 0;
		}
		return false;
	}
}
