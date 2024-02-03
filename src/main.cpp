#include <cstdio>
#include <string>
#include <cstring>
#include <vector>
#include <memory>

#include <logger.hpp>
#include <accounts.hpp>
#include <db.hpp>
#include <ssl.hpp>
#include <zql/ctx.hpp>
#include <types.hpp>
#include <templates.hpp>
#include <openssl/sha.h>
#include <serializator.hpp>
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

ZeonDB::Logger LOG("log");

void version() {
	printf("ZeonDB (%s) - Multi-model, high performance, NoSQL database\n\nBuilt with:\n", ZEON_VERSION);
	printf("%s (%s)\n", SSL_LIBRARY, &SSL_VERSION[strlen(SSL_LIBRARY) + 1]);
	printf("libuv (%s)\n", uv_version_string());
	printf("tomlplusplus (%s)\n", TOMLPLUSPLUS_VERSION);
	printf("argparse (%s)\n", ARGPARSE_VERSION);
	exit(0);
}

ZeonDB::Serializer serializer(".zeondb-dat");

void signal_handler(uv_signal_t *handle, int _) {
    uv_stop(uv_default_loop());
}

int main(int argc, char **argv) {
	argparse::ArgumentParser program("ZeonDB", ZEON_VERSION, argparse::default_arguments::help);

	program.add_argument("-v", "--version")
		.action([=](const std::string& _) {
			version();
		})
		.help("print version of ZeonDB")
		.nargs(0);

	try {
		program.parse_args(argc, argv);
	} catch (const std::exception& err) {
		fprintf(stderr, "%s\n", err.what());
		std::exit(1);
	}

	uv_signal_t sigint;
	uv_signal_init(uv_default_loop(), &sigint);
	uv_signal_start(&sigint, signal_handler, SIGINT);
	
	ZeonDB::DB db;

	unsigned char out[SHA256_DIGEST_LENGTH];

	ZeonDB::SSL::SHA256("paris", out);

	ZeonDB::Accounts::Account acc;
	ZeonDB::Accounts::Permission perm = {
		.can_write = true,
		.can_read = true,
		.can_manage = true,
	};

	memcpy(acc.password, out, SHA256_DIGEST_LENGTH);

	db.register_account("theo", acc);
	db.assign_perm("theo", "$", perm);

	ZeonDB::Template templ;
	templ.add("ahoj", ZeonDB::Types::Value::new_int(0));
	templ.add("cau", ZeonDB::Types::Value::new_float(0.0));
	templ.add("xd", ZeonDB::Types::Value::new_collection());
	templ.add("serus", ZeonDB::Types::Value::new_string(""));
	templ.add("yay", ZeonDB::Types::Value::new_array());

	db.add_template("cau", templ);

	db.run();

	serializer.serialize(db);
	LOG_I("ZeonDB is saving data to the disk!", nullptr);
	LOG_I("ZeonDB end!", nullptr);
	return 0;
}
