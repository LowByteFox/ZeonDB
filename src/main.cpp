#include <cstdio>
#include <string>
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

#ifndef __ORDER_LITTLE_ENDIAN__
#error "__ORDER_LITTLE_ENDIAN__ must be defined, use different compiler!"
#endif

ZeonDB::Logger LOG("log");

int main() {
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

	ZeonDB::TemplateStore store;

	ZeonDB::Template templ;
	templ.add("ahoj", ZeonDB::Types::Value::new_int(0));
	templ.add("cau", ZeonDB::Types::Value::new_float(0.0));
	templ.add("xd", ZeonDB::Types::Value::new_collection());
	templ.add("serus", ZeonDB::Types::Value::new_string(""));
	templ.add("yay", ZeonDB::Types::Value::new_array());

	ZeonDB::Template templ2;
	templ2.add("yay", ZeonDB::Types::Value::new_string("This is different"));

	store.add("cau", templ);
	store.add("serus", templ2);

	printf("%s\n",
			store.create("cau")->stringify(ZeonDB::Types::FormatType::JSON, "theo").c_str());

	printf("%s\n",
			store.create("serus")->stringify(ZeonDB::Types::FormatType::JSON, "theo").c_str());

	// db.run();
	LOG_I("ZeonDB end!", nullptr);
	return 0;
}
