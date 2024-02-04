#include <string>
#include <cstring>

#include <logger.hpp>
#include <accounts.hpp>
#include <fstream>
#include <serializator.hpp>

#include <openssl/sha.h>

namespace ZeonDB::Accounts {
	void AccountManager::register_account(std::string username, Account account) {
		LOG_I("Account \"%s\" was registered!", username.c_str());
		this->accounts[username] = account;
	}

	bool AccountManager::login(std::string username, unsigned char password[SHA256_DIGEST_LENGTH]) {
		LOG_I("Account \"%s\" tried to log in", username.c_str());
		if (this->accounts.contains(username)) {
			Account& account = this->accounts[username];
			return memcmp(password, account.password, SHA256_DIGEST_LENGTH) == 0;
		}
		return false;
	}

	void AccountManager::serialize(std::fstream& stream) {
		size_t len = this->accounts.size();
		stream.write(reinterpret_cast<char*>(&len), sizeof(size_t));

		for (auto& [name, acc] : this->accounts) {
			len = name.length();
			stream.write(reinterpret_cast<char*>(&len), sizeof(size_t));
			stream.write(name.data(), len);
			stream.write(reinterpret_cast<char*>(acc.password), SHA256_DIGEST_LENGTH);
		}
	}

	void AccountManager::unserialize(SerializationContext ctx) {
		size_t count = 0;
		ctx.stream.read(reinterpret_cast<char*>(&count), sizeof(size_t));

		for (int i = 0; i < count; i++) {
			Account a;
			size_t len = 0;
			ctx.stream.read(reinterpret_cast<char*>(&len), sizeof(size_t));
			std::string username(len, 0);
			ctx.stream.read(username.data(), len);
			ctx.stream.read(reinterpret_cast<char*>(a.password), SHA256_DIGEST_LENGTH);

			this->accounts[username] = a;
		}
	}
}
