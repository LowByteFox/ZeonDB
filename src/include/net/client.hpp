#pragma once

#include <string>
#include <map>

#include <uv.h>
#include <db.hpp>
#include <net/server.hpp>
#include <net/frame.hpp>
#include <types.hpp>

namespace ZeonDB::Net {
	class Client {
		private:
			Server *server;
			std::string output;
			std::string user;
			uv_tcp_t client;
			ZeonFrame frame; // for libuv
			uv_buf_t uv_buf;
			std::map<std::string, ZeonDB::Types::ManagedValue> options;

		public:
			std::string buffer; // building command
		 	size_t read;
			size_t transfer_max;
			Client(Server*, uv_tcp_t, std::map<std::string, ZeonDB::Types::ManagedValue>);
			void set_user(std::string);
			ZeonFrame *get_frame();
			std::string get_user();
			uv_tcp_t* get_client();
			Server* get_server();
			void send_message();
			std::map<std::string, ZeonDB::Types::ManagedValue>* get_options();
	};
}
