#pragma once

#include <string>
#include <cstdint>
#include <array>

#include <net/frame.hpp>
#include <uv.h>

namespace ZeonAPI {
	class Connection {
		friend void alloc_header(uv_handle_t*, size_t, uv_buf_t*);
		friend void alloc_transfer(uv_handle_t*, size_t, uv_buf_t*);
		friend void get_frame(uv_stream_t *, ssize_t, const uv_buf_t*);
		friend void transfer_buffer(uv_stream_t *handle, ssize_t nread, const uv_buf_t *buf);
		friend void handle_frame(ZeonAPI::Connection *client, uv_stream_t *stream);

		private:
			uv_loop_t loop;
			uv_tcp_t tcp;
			uv_connect_t conn;
			uv_buf_t uv_buf;
			struct sockaddr_in addr;
			std::string buffer;
			bool authenticated;
			bool connected;
			ZeonDB::Net::ZeonFrame frame;
			size_t read;
			ssize_t transfer_max;

            // LIBUV SUGGESTED
			std::array<char, 65536> transfer_buffer;

			std::string error; // error from operation
			
			void send_message(std::string, ZeonDB::Net::ZeonFrameStatus);

		public:
			Connection(std::string, uint16_t);
			~Connection();
			bool is_up();
			std::string* get_error();
			std::string* get_buffer();
			bool auth(std::string, std::string);
			bool exec(std::string);
	};
}
