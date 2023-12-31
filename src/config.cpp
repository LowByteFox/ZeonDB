#include <string>

#include <logger.hpp>
#include <config.hpp>
#include <toml++/toml.h>

namespace ZeonDB::Conf {
	const std::string default_config = R"(format = "JSON"

[persistence]
enable = false

[branch]
default = "main"
merge_mode = "overwrite"

[accounts]
default = "guest"
[accounts.password]
min_length = 8
max_length = 32

[communication]
max_connections = 128
[communication.ip]
enable = true
port = 6748)";

	Config parse_config(std::string filename) {
		LOG_I("Loading config", nullptr);
		toml::table table;

		if (filename.length() == 0) {
			LOG_W("No config file provided, using default config", nullptr);
			table = toml::parse(default_config);
		} else {
			table = toml::parse_file(filename);
		}

		Config conf;

		conf.format = *table["format"].value<std::string>();

		if (table.contains("persistence")) {
			const auto& persist = table["persistence"].ref<toml::table>();
			conf.persistence.enable = persist["enable"].value_or(false);

			conf.persistence.compression = persist["compression"].value_or("");
			conf.persistence.bundle = persist["bundle"].value_or(false);
			conf.persistence.filename = persist["filename"].value_or("");

		} else {
			conf.persistence.enable = false;
		}

		if (table.contains("branch")) {
			const auto& branch = table["branch"].ref<toml::table>();

			conf.branch.default_name = branch["default"].value_or("main");
			conf.branch.merge_mode = branch["merge_mode"].value_or("overwrite");
		} else {
			conf.branch.default_name = "main";
			conf.branch.merge_mode = "overwrite";
		}

		if (table.contains("accounts")) {
			const auto& accs = table["accounts"].ref<toml::table>();

			conf.accounts.default_name = accs["default"].value_or("guest");

			if (accs.contains("password")) {
				const auto& pass = accs["password"].ref<toml::table>();
				conf.accounts.password.min_length = pass["min_length"].value_or(8);
				conf.accounts.password.max_length = pass["max_length"].value_or(32);
			} else {
				conf.accounts.password.min_length = 8;
				conf.accounts.password.max_length = 32;
			}
		} else {
			conf.accounts.default_name = "guest";
			conf.accounts.password.min_length = 8;
			conf.accounts.password.max_length = 32;
		}

		if (table.contains("communication")) {
			const auto& comm = table["communication"].ref<toml::table>();

			conf.communication.max_connections = comm["max_connections"].value_or(128);

			if (comm.contains("ip")) {
				const auto& ip = comm["ip"].ref<toml::table>();
				conf.communication.ip.enable = ip["enable"].value_or(true);
				conf.communication.ip.port = ip["port"].value_or(6748);
			} else {
				conf.communication.ip.enable = true;
				conf.communication.ip.port = 6748;
			}
		} else {
			conf.communication.max_connections = 128;
			conf.communication.ip.enable = true;
			conf.communication.ip.port = 6748;
		}

		return conf;
	}
}
