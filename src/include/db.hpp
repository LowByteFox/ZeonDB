#pragma once

#include <string>
#include <memory>

#include <accounts.hpp>
#include <config.hpp>
#include <types.hpp>
#include <zql/ctx.hpp>
#include <net/server.hpp>
#include <templates.hpp>

#include <openssl/sha.h>

namespace ZeonDB::Net {
	class Server;
}

namespace ZeonDB {
	class DB {
		private:
			std::shared_ptr<ZeonDB::Types::Value> db;
			Conf::Config conf;
			Accounts::AccountManager accs;
			ZeonDB::Net::Server server;
			TemplateStore templates;

		public:
			DB();
			void register_account(std::string, Accounts::Account);
			void add_template(std::string, Template);
			bool login(std::string, unsigned char[SHA256_DIGEST_LENGTH]);
			void assign_perm(std::string, std::string, Accounts::Permission);
			ZQL::ZqlTrace execute(std::string, std::string);
			void run();
	};
}
