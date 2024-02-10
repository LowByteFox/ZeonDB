#include <cstdint>
#include <algorithm>
#include <cstdio>
#include <sstream>

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

void alloc_buffer(uv_handle_t*, size_t, uv_buf_t*);
void get_frame(uv_stream_t *, ssize_t, const uv_buf_t*);
void transfer_buffer(uv_stream_t *handle, ssize_t nread, const uv_buf_t *buf);
void client_close(uv_handle_t *);

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

		cl->send_message("", ZeonFrameStatus::Ok);
		uv_read_start((uv_stream_t*) cl->get_client(), alloc_buffer, get_frame);
	}
}

void alloc_buffer(uv_handle_t *handle, size_t suggest, uv_buf_t *buf) {
	auto* client = static_cast<ZeonDB::Net::Client*>(handle->data);
    client->buffer.resize(client->buffer.size() + suggest);

    buf->base = client->buffer.data() + client->read;
	buf->len = suggest;
}

void close_client(uv_handle_t *handle) {
	auto* client = static_cast<ZeonDB::Net::Client*>(handle->data);
	uv_stop(client->get_server()->get_loop());
	delete client;
}

void handle_frame(ZeonDB::Net::Client *client, uv_stream_t *stream) {
	auto* frame = &client->frame;

	switch (frame->get_status()) {
		case ZeonFrameStatus::Auth:
			{
				LOG_D("Recieved AUTH", nullptr);
				std::string msg = client->buffer.data() + 9;

				size_t index = std::distance(msg.begin(), std::find(msg.begin(), msg.end(), ' '));
				std::string username;
				username.append(msg.data(), index);
				index += 1;
				std::array<unsigned char, SHA256_DIGEST_LENGTH> password;

				memcpy(password.data(), msg.data() + index, SHA256_DIGEST_LENGTH);

				if (client->get_server()->get_db()->login(username.data(), password.data())) {
					LOG_I("User \"%s\" logged in", username.c_str());
					client->set_user(username);

					std::string res = "OK";
					client->send_message(res, ZeonFrameStatus::Auth);
				} else {
					LOG_W("Wrong login!", nullptr);
					std::string err = "ER Bad username or password";
					client->send_message(err, ZeonFrameStatus::Auth);
				}
			}
			break;
		case ZeonFrameStatus::Command:
			{
				LOG_D("Recieved COMMAND", nullptr);
				LOG_D("Executing!", nullptr);
				ZeonDB::ZQL::ZqlTrace trace = client->get_server()->get_db()->execute(client->buffer.data() + 9, client->get_user(), client);

				if (trace.error.length() > 0) {
					LOG_D("Execution ended with an Error!", nullptr);
					client->send_message(trace.error, ZeonFrameStatus::Error);
				} else if (trace.value != nullptr) {
					LOG_D("Execution ended with a Value!", nullptr);

					FormatType fmtType = FormatType::JSON;
					auto opts = client->get_opts();
					if ((*opts)["format"].v.s.compare("ZQL") == 0) {
						fmtType = FormatType::ZQL;
					}
					std::stringstream stream;
					trace.value->stringify(fmtType, client->get_user(), stream);
					std::string res = stream.str();

					client->send_message(res, ZeonFrameStatus::Command);
				} else {
					LOG_D("Execution ended", nullptr);
					std::string res = "OK";

					client->send_message(res, ZeonFrameStatus::Command);
				}

				break;
			}
		default:
			break;
	}

	client->buffer = "";
    client->header_parsed = false;
    client->read = 0;
}

void get_frame(uv_stream_t *handle, ssize_t nread, const uv_buf_t *buf) {
	auto* client = static_cast<ZeonDB::Net::Client*>(handle->data);

	if (nread == UV_EOF) {
		LOG_I("Client disconnected!", nullptr);
		uv_read_stop(handle);
        uv_close((uv_handle_t*) handle, client_close);
		return;
	}

	if (nread > 0) {
		if (client->buffer.size() >= 9) {
			LOG_D("Received a frame!", nullptr);
            if (!client->header_parsed) {
                char *buff = client->frame.get_buffer();
                memcpy(buff, client->buffer.data(), 9);
    			client->frame.from_buffer();
    			client->transfer_max = client->frame.get_length() - nread + 9;
                client->read = nread;
                client->header_parsed = true;
            } else {
    			client->transfer_max -= nread;
                client->read += nread;
            }

			if (client->transfer_max <= 0) {
                client->buffer.resize(client->read);
				handle_frame(client, handle);
			}
		}
	} else if (nread == 0) {
	} else {
		LOG_E("%s", uv_strerror(nread));
		uv_read_stop(handle);
        uv_close((uv_handle_t*) handle, client_close);
	}
}

void client_close(uv_handle_t *handle) {
	auto* client = static_cast<ZeonDB::Net::Client*>(handle->data);
    delete client;
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
        printf("\r");
		LOG_I("Stopping server!", nullptr);
	}
}
