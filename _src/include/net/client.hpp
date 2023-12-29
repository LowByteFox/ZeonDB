#pragma once

#include <string>

#include <uv.h>
#include <db.hpp>
#include <net/server.hpp>
#include <net/frame.hpp>

namespace ZeonDB::Net {
	class Client {
		private:
			Server *server;
			std::string buffer; // building command
			std::string output;
			std::string user;
			uv_tcp_t client;
			ZeonFrame frame; // for libuv
			uv_buf_t uv_buf;

		public:
		 	size_t read;
			Client(Server*, uv_tcp_t);
			void set_user(std::string);
			ZeonFrame *get_frame();
			uv_tcp_t* get_client();
			Server* get_server();
			void send_message();
	};
}
