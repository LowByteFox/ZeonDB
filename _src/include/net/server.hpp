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

		public:
			void configure(uint16_t);
			void serve(ZeonDB::DB*);
			ZeonDB::DB* get_db();
			uv_loop_t* get_loop();
	};
}
