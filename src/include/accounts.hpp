#pragma once

#include <string>
#include <map>
#include <fstream>

#include <openssl/sha.h>

namespace ZeonDB {
	struct SerializationContext;
}

namespace ZeonDB::Accounts {
	struct Permission {
		bool can_write;
		bool can_read;
		bool can_manage;
	};

	struct Account {
		unsigned char password[SHA256_DIGEST_LENGTH];
        bool special;
	};

	class AccountManager {
		private:
			std::map<std::string, Account> accounts;

		public:
            std::string def_user = "dummy";

			void register_account(std::string, Account);
			bool login(std::string, unsigned char[SHA256_DIGEST_LENGTH]);
            bool delete_account(std::string);
            bool has_account(std::string);
			void serialize(std::fstream&);
			void unserialize(SerializationContext);
            size_t account_count();
            Account* get_account(std::string);
	};
}
