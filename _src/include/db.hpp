#pragma once

#include <string>
#include <memory>

#include <accounts.hpp>
#include <config.hpp>
#include <collection.hpp>
#include <zql/ctx.hpp>

#include <openssl/sha.h>

namespace ZeonDB {
	class DB {
		private:
			std::shared_ptr<Collection> db;
			Conf::Config conf;
			Accounts::AccountManager accs;
			// TODO: NETWORKING
		public:
			DB();
			void register_account(std::string, Accounts::Account);
			bool login(std::string, unsigned char[SHA256_DIGEST_LENGTH]);
			void assign_perm(std::string, std::string, Accounts::Permission);
			ZQL::ZqlTrace execute(std::string, std::string);
	};
}
