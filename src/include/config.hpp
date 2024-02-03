#pragma once

#include <string>

#include <toml++/toml.h>

namespace ZeonDB::Conf {
	struct Config {
		std::string format; // ZQL | JSON
		struct {
			bool enable;
			std::string compression; // gzip | xz | zstd
			bool bundle; // combine persisted data into single archive ideal for backups and migration
			std::string filename; // name of the archive ( prefix if not bundle )
		} persistence;
		struct {
			std::string merge_mode; // no_overwrite | overwrite | overwrite_partial | swap
		} branch;
		struct {
			std::string default_name; // name of the default account
			struct {
				size_t min_length;
				size_t max_length;
			} password;
		} accounts;
		struct {
			size_t max_connections;
			struct {
				bool enable;
				unsigned short port;
			} ip;
		} communication;
	};

	Config parse_config(std::string);
}
