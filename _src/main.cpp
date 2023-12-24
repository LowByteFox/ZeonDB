#include <cstdio>

#include <types.hpp>
#include <collection.hpp>
#include <config.hpp>

using ZeonDB::Conf::Config;
using ZeonDB::Conf::parse_config;

int main() {
	Config conf = parse_config("");
	printf("%s\n", conf.format.c_str());
	printf("%d\n", conf.persistence.enable);
	printf("%s\n", conf.branch.default_name.c_str());
	printf("%s\n", conf.branch.merge_mode.c_str());
	printf("%s\n", conf.accounts.default_name.c_str());
	printf("%zu\n", conf.accounts.password.min_length);
	printf("%zu\n", conf.accounts.password.max_length);
	printf("%zu\n", conf.communication.max_connections);
	printf("%d\n", conf.communication.ip.enable);
	printf("%hu\n", conf.communication.ip.port);
	return 0;
}
