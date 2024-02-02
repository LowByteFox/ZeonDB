#pragma once

#include <cstdint>

#include <db.hpp>
#include <uv.h>

namespace ZeonDB {
	class DB;
}

namespace ZeonDB::Net {
	class Server {
		private:
			struct sockaddr_in addr;
			uint16_t port;
			ZeonDB::DB* db;
			uv_loop_t *loop;
			std::map<std::string, ZeonDB::Types::ManagedValue> *options;

		public:
			void configure(uint16_t, std::map<std::string, ZeonDB::Types::ManagedValue>*);
			void serve(ZeonDB::DB*);
			ZeonDB::DB* get_db();
			std::map<std::string, ZeonDB::Types::ManagedValue> *get_options();
			uv_loop_t* get_loop();
	};
}
