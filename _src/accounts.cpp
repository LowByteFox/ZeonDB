#include <string>
#include <cstring>

#include <logger.hpp>
#include <accounts.hpp>

#include <openssl/sha.h>

namespace ZeonDB::Accounts {
	void AccountManager::register_account(std::string username, Account account) {
		LOG_I("Account \"%s\" was registered!", username.c_str());
		this->accounts.emplace(username, account);
	}

	bool AccountManager::login(std::string username, unsigned char password[SHA256_DIGEST_LENGTH]) {
		LOG_I("Account \"%s\" tried to log in", username.c_str());
		if (this->accounts.contains(username)) {
			Account& account = this->accounts[username];
			return memcmp(password, account.password, SHA256_DIGEST_LENGTH) == 0;
		}
		return false;
	}
}
