#pragma once

#include <string>
#include <map>
#include <array>

#include <uv.h>
#include <db.hpp>
#include <net/server.hpp>
#include <net/frame.hpp>
#include <types.hpp>

namespace ZeonDB::Net {
	class Client {
		private:
			Server *server;
			std::string user;
			uv_tcp_t client;
			std::map<std::string, ZeonDB::Types::Value> opts;
			bool opts_set;

		public:
            // LIBUV SUGGESTS
			ZeonFrame frame; // for libuv
			std::string buffer; // transfer buffer
			ssize_t transfer_max; // gets substracted
            bool header_parsed; // if the header was parsed
            size_t read;

			Client(Server*, uv_tcp_t);

			void set_user(std::string);

			std::string& get_user();
			uv_tcp_t* get_client();
			Server* get_server();

			void send_message(std::string, ZeonFrameStatus);

			bool has_opts();
			void set_opts(std::map<std::string, ZeonDB::Types::Value>*);
			std::map<std::string, ZeonDB::Types::Value>* get_opts();
	};
}
