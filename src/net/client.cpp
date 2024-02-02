#include <uv.h>
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
	Client::Client(Server *server, uv_tcp_t connection, std::map<std::string, ZeonDB::Types::ManagedValue> opts) {
		this->server = server;
		this->client = connection;
		this->read = 0;
		this->buffer = "";
		this->output = "";
		this->options = opts;
	}

	void Client::set_user(std::string login) {
		this->user = login;
	}

	std::string Client::get_user() {
		return this->user;
	}

	uv_tcp_t *Client::get_client() {
		return &this->client;
	}

	ZeonFrame* Client::get_frame() {
		return &this->frame;
	}

	Server* Client::get_server() {
		return this->server;
	}

	void Client::send_message() {
		uv_write_t* req = new uv_write_t;
		this->uv_buf = uv_buf_init(this->frame.get_buffer(), 1024);
		uv_write(req, (uv_stream_t*) &this->client, &this->uv_buf, 1, send_msg);
	}

	std::map<std::string, ZeonDB::Types::ManagedValue>* Client::get_options() {
		return &this->options;
	}
}
