#pragma once

#include <string>
#include <memory>
#include <fstream>

#include <accounts.hpp>
#include <config.hpp>
#include <types.hpp>
#include <zql/ctx.hpp>
#include <net/server.hpp>
#include <net/client.hpp>
#include <templates.hpp>

#include <openssl/sha.h>

namespace ZeonDB::Net {
	class Server;
	class Client;
}

namespace ZeonDB {
	class DB {
		private:
			std::shared_ptr<ZeonDB::Types::Value> db;
			Conf::Config conf;
			Accounts::AccountManager accs;
			ZeonDB::Net::Server server;
			TemplateStore templates;
			std::map<std::string, ZeonDB::Types::Value> opts;

		public:
			DB();
			void register_account(std::string, Accounts::Account);
			void add_template(std::string, Template);
            bool has_account(std::string);
            size_t account_count();
			bool login(std::string, unsigned char[SHA256_DIGEST_LENGTH]);
			void assign_perm(std::string, std::string, Accounts::Permission);
			ZQL::ZqlTrace execute(std::string, std::string, ZeonDB::Net::Client*);
			void run();
			void serialize(std::fstream&);
			void unserialize(std::fstream&);

			void serialize_accounts(std::fstream&);
			void unserialize_accounts(std::fstream&);

			void serialize_templates(std::fstream&);
			void unserialize_templates(std::fstream&);
	};
}
