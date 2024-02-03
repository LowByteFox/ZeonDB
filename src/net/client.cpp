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
		this->buffer = "";
		this->output = "";
		this->opts_set = false;
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

	void Client::send_message() {
		uv_write_t* req = new uv_write_t;
		this->uv_buf = uv_buf_init(this->frame.get_buffer(), 1024);
		uv_write(req, (uv_stream_t*) &this->client, &this->uv_buf, 1, send_msg);
	}
}
