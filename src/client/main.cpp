#include <cstdio>
#include <iostream>
#include <string>

#include <client/zeonapi.hpp>

#include <argparse/argparse.hpp>

#include <uv.h>
#include <openssl/opensslv.h>
#include <cstring>

#if defined(_WIN32) || defined(__LITTLE_ENDIAN__) ||(defined(__BYTE_ORDER__) && __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__)
#elif defined(__BIG_ENDIAN__) || (defined(__BYTE_ORDER__) && __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__)
#error "No little endian :("
#else
#error "No little endian :("
#endif

#ifdef LIBRESSL_VERSION_NUMBER
	#define SSL_LIBRARY "LibreSSL"
	#define SSL_VERSION LIBRESSL_VERSION_TEXT
#elif defined(OPENSSL_VERSION_NUMBER)
	#define SSL_LIBRARY "OpenSSL"
	#define SSL_VERSION OPENSSL_VERSION_TEXT
#endif

void version() {
	printf("ZeonCTL (%s) - Console client for ZeonDB\n\nBuilt with:\n", ZEON_VERSION);
	printf("%s (%s)\n", SSL_LIBRARY, &SSL_VERSION[strlen(SSL_LIBRARY) + 1]);
	printf("libuv (%s)\n", uv_version_string());
	printf("argparse (%s)\n", ARGPARSE_VERSION);
	exit(0);
}

int main(int argc, char **argv) {
	argparse::ArgumentParser program("ZeonCTL", ZEON_VERSION, argparse::default_arguments::help);

	program.add_argument("-v", "--version")
		.action([=](const std::string& _) {
			version();
		})
		.help("print version of ZeonCTL")
		.nargs(0);

    program.add_argument("--host")
        .default_value<std::string>("127.0.0.1")
        .nargs(1)
        .help("Specify ip of host to connect to");

    program.add_argument("--port")
        .default_value<size_t>(6748)
        .nargs(1)
        .help("Specify port of the host to connect to");

	try {
		program.parse_args(argc, argv);
	} catch (const std::exception& err) {
		fprintf(stderr, "%s\n", err.what());
		std::exit(1);
	}

    std::string host = program.get<std::string>("--host");

	ZeonAPI::Connection zeon(host, program.get<size_t>("--port"));

	std::string username;
	std::string password;

	printf("Username: ");
	std::getline(std::cin, username);
	printf("Password: ");
	std::getline(std::cin, password);

	if (zeon.auth(username, password)) {
		while (true) {
			printf("(%s@%s)> ", username.c_str(), host.c_str());
			std::string cmd;
			std::getline(std::cin, cmd);

			if (cmd.compare("exit") == 0) {
				break;
			}

			if (!zeon.exec(cmd)) {
				printf("%s\n", zeon.get_error()->c_str());
			} else {
				printf("%s\n", zeon.get_buffer()->c_str() + 9);
			}
		}
	} else {
		fprintf(stderr, "Could not login! %s\n", zeon.get_error()->c_str());
	}
}
