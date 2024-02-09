#include <uv.h>
#include <memory>
#include <logger.hpp>
#include <types.hpp>
#include <net/client.hpp>
#include <net/server.hpp>
#include <net/frame.hpp>

void send_msg(uv_write_t *req, int status) {
    if (status) {
        fprintf(stderr, "Write error %s\n", uv_strerror(status));
    }

    delete req;
}

namespace ZeonDB::Net {
	Client::Client(Server *server, uv_tcp_t connection) {
		this->server = server;
		this->client = connection;
		this->read = 0;
		this->transfer_max = 0;
		this->buffer = "";
		this->user = "";
		this->opts_set = false;
	}

	void Client::set_user(std::string login) {
		this->user = login;
	}

	std::string& Client::get_user() {
		return this->user;
	}

	uv_tcp_t *Client::get_client() {
		return &this->client;
	}

	Server* Client::get_server() {
		return this->server;
	}

	bool Client::has_opts() {
		return this->opts_set;
	}

	void Client::set_opts(std::map<std::string, ZeonDB::Types::Value>* val) {
		this->opts = *val;
		this->opts_set = true;
	}

	std::map<std::string, ZeonDB::Types::Value>* Client::get_opts() {
		return &this->opts;
	}

	void Client::send_message(std::string buf, ZeonFrameStatus status) {
		size_t len = buf.length();

		this->frame.to_buffer(status, len);

		std::vector<std::string> strs;
		std::vector<uv_buf_t> vec;

		for (int i = 0; i <= len; i += 1024) {
			strs.push_back(buf.substr(i, 1024));

			if (i == 0) {
				char *frame_buffer = this->frame.get_buffer();
				std::string first_packet(9 + (status == ZeonFrameStatus::Ok ? 0 : 1024), 0);
				
				memcpy(first_packet.data(), frame_buffer, 9);

				if (status != ZeonFrameStatus::Ok) {
					std::string& back_ref = strs.back();
					memcpy(first_packet.data() + 9, back_ref.data(), back_ref.length());
					strs.push_back(first_packet);
					vec.push_back(uv_buf_init(strs.back().data(), first_packet.length()));
				} else {
					strs.push_back(first_packet);
					vec.push_back(uv_buf_init(strs.back().data(), first_packet.length()));
				}
				continue;
			}

			std::string& back_ref = strs.back();
			back_ref.resize(1024, 0);
			vec.push_back(uv_buf_init(back_ref.data(), back_ref.length()));
		}

		uv_write_t* req = new uv_write_t;
		uv_write(req, (uv_stream_t*) &this->client, vec.data(), vec.size(), send_msg);
	}
}
