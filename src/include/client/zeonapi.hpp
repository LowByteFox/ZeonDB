#pragma once

#include <string>
#include <cstdint>

#include <net/frame.hpp>
#include <uv.h>

namespace ZeonAPI {
	class Connection {
		friend void on_read(uv_stream_t *stream, ssize_t nread, const uv_buf_t* _);
		friend void alloc_buff(uv_handle_t *handle, size_t _, uv_buf_t *buf);
		friend void handle_frame(ZeonAPI::Connection *client, uv_stream_t *stream);

		private:
			uv_loop_t *loop;
			uv_tcp_t tcp;
			uv_connect_t conn;
			uv_buf_t uv_buf;
			struct sockaddr_in addr;
			std::string buffer;
			bool authenticated;
			bool connected;
			ZeonDB::Net::ZeonFrame frame;
			size_t read;

			std::string error; // error from operation
			
			void send_message();

		public:
			Connection(std::string, uint16_t);
			~Connection();
			bool is_up();
			std::string get_error();
			std::string get_buffer();
			bool auth(std::string, std::string);
			bool exec(std::string);
	};
}
