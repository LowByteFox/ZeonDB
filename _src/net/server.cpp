#include <cstdint>
#include <algorithm>
#include <cstdio>

#include <db.hpp>
#include <uv.h>
#include <net/server.hpp>
#include <net/frame.hpp>
#include <net/client.hpp>

#include <openssl/sha.h>

using ZeonDB::Net::ZeonFrameStatus;

void alloc_buff(uv_handle_t*, size_t, uv_buf_t*);
void get_frame(uv_stream_t *, ssize_t, const uv_buf_t*);

void on_connect(uv_stream_t *server, int status) {
	auto* s = static_cast<ZeonDB::Net::Server*>(server->data);

	uv_tcp_t client;
	auto* cl = new ZeonDB::Net::Client(s, client);
	uv_tcp_init(s->get_loop(), cl->get_client());

	if (uv_accept(server, (uv_stream_t*) cl->get_client()) == 0) {
		cl->get_client()->data = cl;
		auto frame = cl->get_frame();
		frame->to_buffer(ZeonFrameStatus::Ok, 0);

		cl->send_message();
		uv_read_start((uv_stream_t*) cl->get_client(), alloc_buff, get_frame);
	}
}

void alloc_buff(uv_handle_t *handle, size_t _, uv_buf_t *buf) {
	auto* client = static_cast<ZeonDB::Net::Client*>(handle->data);
	auto frame = client->get_frame();

	if (client->read > 0) {
		buf->len = 1024 - client->read;
		buf->base = frame->get_buffer() + client->read;
	}

    buf->base = frame->get_buffer();
	buf->len = 1024;
}

void close_client(uv_handle_t *handle) {
	auto* client = static_cast<ZeonDB::Net::Client*>(handle->data);
	uv_stop(client->get_server()->get_loop());
	delete client;
}

void handle_frame(ZeonDB::Net::Client *client) {
	auto* frame = client->get_frame();

	switch (frame->get_status()) {
		case ZeonFrameStatus::Ok:
			break;
		case ZeonFrameStatus::Auth:
			{
				auto msg = frame->read_buffer();
				size_t index = std::distance(msg.data(), std::find(msg.data(), msg.data() + 1015, ' '));
				std::string username;
				username.reserve(index);
				memcpy(username.data(), msg.data(), index);
				index += 1;
				std::array<unsigned char, SHA256_DIGEST_LENGTH> password;
				memcpy(password.data(), msg.data() + index, SHA256_DIGEST_LENGTH);

				if (client->get_server()->get_db()->login(username.data(), password.data())) {
					client->set_user(username);

					memcpy(msg.data(), "OK", 2);
					frame->to_buffer(ZeonFrameStatus::Auth, 2);
					frame->write_buffer(msg);
					client->send_message();
				} else {
					std::string err = "ER Bad username or password";
					memcpy(msg.data(), err.data(), err.size());
					frame->to_buffer(ZeonFrameStatus::Auth, err.size());
					frame->write_buffer(msg);
					client->send_message();
				}
			}
			break;
	}
}

void get_frame(uv_stream_t *handle, ssize_t nread, const uv_buf_t *buf) {
	auto* client = static_cast<ZeonDB::Net::Client*>(handle->data);

	if (nread == UV_EOF) {
		uv_read_stop(handle);
		uv_close((uv_handle_t*)client->get_client(), close_client);
		return;
	}

	if (nread > 0) {
		client->read += nread;

		if (client->read == 1024) {
			auto frame = client->get_frame();
			frame->from_buffer();
			handle_frame(client);
		}
	} else if (nread == 0) {
	} else {
		printf("%s\n", uv_strerror(nread));
		uv_stop(client->get_server()->get_loop());
	}
}

namespace ZeonDB::Net {
	void Server::configure(uint16_t port) {
		uv_ip4_addr("0.0.0.0", port, &this->addr);


		this->port = port;
		this->loop = uv_default_loop();
	}

	ZeonDB::DB* Server::get_db() {
		return this->db;
	}

	uv_loop_t* Server::get_loop() {
		return this->loop;
	}

	void Server::serve(ZeonDB::DB* db) {
		this->db = db;

		uv_tcp_t server;
		uv_tcp_init(this->loop, &server);
		uv_tcp_bind(&server, (const struct sockaddr*)&this->addr, 0);

		int res = uv_listen((uv_stream_t*)&server, 128, on_connect);

		if (res > 0) {
			fprintf(stderr, "Listen error: %s\n", uv_strerror(res));
			return;
		}

		server.data = this;

		printf("Running on port %d\n", this->port);
		uv_run(this->loop, UV_RUN_DEFAULT);
	}
}
