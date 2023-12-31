#include <db.hpp>
#include <logger.hpp>
#include <config.hpp>
#include <types.hpp>
#include <zql/parser.hpp>
#include <zql/ctx.hpp>
#include <net/server.hpp>

#include <memory>
#include <string>
#include <vector>
#include <filesystem>

#include <openssl/sha.h>

namespace ZeonDB {
	DB::DB() {
		LOG_I("ZeonDB is starting...", nullptr);
		this->db = ZeonDB::Types::Value::new_collection();

		bool check_system = true;
		bool configured = false;

		if (std::filesystem::exists("./zeondb.toml")) {
			this->conf = Conf::parse_config("./zeondb.toml");
			check_system = false;
			configured = true;
		}

		if (check_system && std::filesystem::exists("/etc/zeondb.toml")) {
			this->conf = Conf::parse_config("/etc/zeondb.toml");
			configured = true;
		}

		if (!configured) {
			this->conf = Conf::parse_config("");
		}

		this->server.configure(this->conf.communication.ip.port);
	}

	void DB::add_template(std::string name, Template templ) {
		this->templates.add(name, templ);
	}

	void DB::register_account(std::string username, Accounts::Account acc) {
		this->accs.register_account(username, acc);
	}

	bool DB::login(std::string username, unsigned char encrypted_password[SHA256_DIGEST_LENGTH]) {
		return this->accs.login(username, encrypted_password);
	}

	void DB::assign_perm(std::string username, std::string key, Accounts::Permission perm) {
		this->db->v.c.assign_perm(username, key, perm);
	}

	void DB::run() {
		LOG_I("ZeonDB ready!", nullptr);
		this->server.serve(this);
	}

	ZQL::ZqlTrace DB::execute(std::string script, std::string username) {
		ZQL::Parser parser(this->db, script);
		std::vector<ZQL::Context> ctxs = parser.parse();

		std::shared_ptr<ZeonDB::Types::Value> tmp_buffer;


		for (auto& ctx : ctxs) {
			ctx.amgr = &this->accs;
			ctx.templ_store = &this->templates;
			ctx.set_user(username);
			if (ctx.error.length() > 0) {
				return (ZQL::ZqlTrace) {
					.value = nullptr,
					.error = ctx.error,
				};
			}

			ctx.execute(&tmp_buffer);

			if (ctx.error.length() > 0) {
				return (ZQL::ZqlTrace) {
					.value = nullptr,
					.error = ctx.error,
				};
			}
		}

		return (ZQL::ZqlTrace) {
			.value = tmp_buffer,
			.error = "",
		};
	}
}
