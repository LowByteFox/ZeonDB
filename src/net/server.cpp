#include <cstdint>
#include <algorithm>
#include <cstdio>

#include <logger.hpp>
#include <db.hpp>
#include <uv.h>
#include <net/server.hpp>
#include <net/frame.hpp>
#include <net/client.hpp>
#include <types.hpp>
#include <zql/ctx.hpp>

#include <openssl/sha.h>

using ZeonDB::Net::ZeonFrameStatus;
using ZeonDB::Types::FormatType;

void alloc_buff(uv_handle_t*, size_t, uv_buf_t*);
void get_frame(uv_stream_t *, ssize_t, const uv_buf_t*);

void on_connect(uv_stream_t *server, int status) {
	auto* s = static_cast<ZeonDB::Net::Server*>(server->data);

	uv_tcp_t client;
	auto* cl = new ZeonDB::Net::Client(s, client);
	uv_tcp_init(s->get_loop(), cl->get_client());

	if (uv_accept(server, (uv_stream_t*) cl->get_client()) == 0) {
		struct sockaddr_storage addr;
		int len = sizeof(addr);
		char ip[INET6_ADDRSTRLEN];
		int port;

		uv_tcp_getpeername(cl->get_client(), (struct sockaddr*)&addr, &len);

		if (addr.ss_family == AF_INET) {
			uv_ip4_name((struct sockaddr_in*)&addr, ip, sizeof(ip));
			port = ntohs(((struct sockaddr_in*)&addr)->sin_port);
		} else { 
			uv_ip6_name((struct sockaddr_in6*)&addr, ip, sizeof(ip));
			port = ntohs(((struct sockaddr_in6*)&addr)->sin6_port);
		}

		LOG_I("New client! %s:%d", ip, port);

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

void handle_frame(ZeonDB::Net::Client *client, uv_stream_t *stream) {
	auto* frame = client->get_frame();

	client->read = 0;
	switch (frame->get_status()) {
		case ZeonFrameStatus::Auth:
			{
				LOG_V("Recieved AUTH", nullptr);
				auto msg = frame->read_buffer();
				size_t index = std::distance(msg.data(), std::find(msg.data(), msg.data() + 1015, ' '));
				std::string username;
				username.append(msg.data(), index);
				index += 1;
				std::array<unsigned char, SHA256_DIGEST_LENGTH> password;
				memcpy(password.data(), msg.data() + index, SHA256_DIGEST_LENGTH);

				if (client->get_server()->get_db()->login(username.data(), password.data())) {
					LOG_I("User \"%s\" logged in", username.c_str());
					client->set_user(username);

					memcpy(msg.data(), "OK", 2);
					frame->to_buffer(ZeonFrameStatus::Auth, 2);
					frame->write_buffer(msg);
					client->send_message();
				} else {
					LOG_W("Wrong login!", nullptr);
					std::string err = "ER Bad username or password";
					memcpy(msg.data(), err.data(), err.size());
					frame->to_buffer(ZeonFrameStatus::Auth, err.size());
					frame->write_buffer(msg);
					client->send_message();
				}
			}
			break;
		case ZeonFrameStatus::Command:
			{
				LOG_V("Recieved COMMAND", nullptr);
				auto msg = frame->read_buffer();

				client->buffer = "";
				client->buffer.append(msg.data(), frame->get_length());

				LOG_D("Command: %s", client->buffer.c_str());

				LOG_V("Executing!", nullptr);
				ZeonDB::ZQL::ZqlTrace trace = client->get_server()->get_db()->execute(client->buffer, client->get_user(), client);

				if (trace.error.length() > 0) {
					LOG_V("Execution ended with an Error!", nullptr);
					memcpy(msg.data(), trace.error.data(), trace.error.length());
					frame->to_buffer(ZeonFrameStatus::Error, trace.error.length());
					frame->write_buffer(msg);

					client->send_message();
				} else if (trace.value != nullptr) {
					LOG_V("Execution ended with a Value!", nullptr);
					FormatType fmtType = FormatType::JSON;
					if (client->has_opts()) {
						auto opts = client->get_opts();
						if ((*opts)["format"].v.s.compare("ZQL") == 0) {
							fmtType = FormatType::ZQL;
						}
					}
					std::string res = trace.value->stringify(fmtType, client->get_user());
					memcpy(msg.data(), res.data(), res.length());
					frame->to_buffer(ZeonFrameStatus::Command, res.length());
					frame->write_buffer(msg);

					client->send_message();
				} else {
					LOG_V("Execution ended", nullptr);
					memcpy(msg.data(), "OK", 2);
					frame->to_buffer(ZeonFrameStatus::Command, 2);
					frame->write_buffer(msg);

					client->send_message();
				}

				client->buffer = "";
				break;
			}
		default:
			break;
	}
}

void get_frame(uv_stream_t *handle, ssize_t nread, const uv_buf_t *buf) {
	auto* client = static_cast<ZeonDB::Net::Client*>(handle->data);

	if (nread == UV_EOF) {
		LOG_I("Client disconnected!", nullptr);
		uv_read_stop(handle);
		return;
	}

	if (nread > 0) {
		client->read += nread;
		auto frame = client->get_frame();

		if (client->read == 1024) {
			LOG_V("Received a frame!", nullptr);
			frame->from_buffer();
			handle_frame(client, handle);
		}
	} else if (nread == 0) {
	} else {
		LOG_E("%s", uv_strerror(nread));
		uv_stop(client->get_server()->get_loop());
	}
}

namespace ZeonDB::Net {
	void Server::configure(uint16_t port) {
		LOG_I("Configuring the server!", nullptr);
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

		if (res != 0) {
			LOG_E("Listen error: %s", uv_strerror(res));
			return;
		}

		server.data = this;

		LOG_I("Running on port %d", this->port);
		uv_run(this->loop, UV_RUN_DEFAULT);
		LOG_I("Stopping server!", nullptr);
	}
}
