#include <client/zeonapi.hpp>

#include <cmath>
#include <cstdio>
#include <cstring>
#include <cstdint>
#include <string>

#include <uv.h>
#include <ssl.hpp>
#include <openssl/sha.h>

using ZeonDB::Net::ZeonFrameStatus;

void on_connect(uv_connect_t *_, int status) {
	if (status < 0) {
		fprintf(stderr, "Could not connect to ZeonDB! %s\n", uv_strerror(status));
		return;
	}
}

void send_msg(uv_write_t *req, int status) {
    if (status) {
        fprintf(stderr, "Write error %s\n", uv_strerror(status));
    }

    delete req;
}

#ifndef MIN
#define MIN(a,b) (((a)<(b))?(a):(b))
#endif

namespace ZeonAPI {
	void on_read(uv_stream_t *stream, ssize_t nread, const uv_buf_t* _);
	void alloc_buff(uv_handle_t *handle, size_t _, uv_buf_t *buf);
	void handle_frame(ZeonAPI::Connection *client, uv_stream_t stream);

	Connection::Connection(std::string ip, uint16_t port) {
		this->read = 0;
		this->authenticated = false;
		this->connected = false;

		uv_loop_init(&this->loop);

		uv_ip4_addr(ip.c_str(), port, &this->addr);
		uv_tcp_init(&this->loop, &this->tcp);
		uv_tcp_connect(&this->conn, &this->tcp, (const struct sockaddr*)&this->addr, on_connect);
		
		this->tcp.data = this;

		uv_run(&this->loop, UV_RUN_ONCE); // Debilny windows sprosty
		uv_read_start((uv_stream_t*) &this->tcp, alloc_buff, on_read);
		uv_run(&this->loop, UV_RUN_DEFAULT);
		this->connected = true;
	}

	Connection::~Connection() {
		uv_close((uv_handle_t*) &this->tcp, nullptr);
		uv_run(&this->loop, UV_RUN_ONCE);
		uv_loop_close(&this->loop);
		this->connected = false;
		this->authenticated = false;
	}

	bool Connection::auth(std::string username, std::string password) {
		unsigned char out[SHA256_DIGEST_LENGTH + 1];
		ZeonDB::SSL::SHA256(password.c_str(), out);
		out[SHA256_DIGEST_LENGTH] = 0;

		std::string msg = username + " ";
		msg.append((char *) out);

		auto buffer = this->frame.read_buffer();
		strncpy(buffer.data(), msg.data(), MIN(msg.length(), 1015));
		this->frame.to_buffer(ZeonFrameStatus::Auth, msg.length());
		this->frame.write_buffer(buffer);

		this->send_message();
		uv_read_start((uv_stream_t*) &this->tcp, alloc_buff, on_read);
		uv_run(&this->loop, UV_RUN_DEFAULT);

		return this->authenticated;
	}

	bool Connection::exec(std::string command) {
		this->error = "";
		this->buffer = "";

		auto buffer = this->frame.read_buffer();
		strncpy(buffer.data(), command.data(), MIN(command.length(), 1015));
		this->frame.to_buffer(ZeonFrameStatus::Command, command.length());
		this->frame.write_buffer(buffer);

		this->send_message();
		uv_read_start((uv_stream_t*) &this->tcp, alloc_buff, on_read);
		uv_run(&this->loop, UV_RUN_DEFAULT);

		return this->error.length() == 0;
	}

	bool Connection::is_up() {
		return this->connected;
	}

	std::string* Connection::get_error() {
		return &this->error;
	}

	std::string* Connection::get_buffer() {
		return &this->buffer;
	}

	void Connection::send_message() {
		uv_write_t* req = new uv_write_t;
		this->uv_buf = uv_buf_init(this->frame.get_buffer(), 1024);
		uv_write(req, (uv_stream_t*) &this->tcp, &this->uv_buf, 1, send_msg);
	}

	void alloc_buff(uv_handle_t *handle, size_t _, uv_buf_t *buf) {
		auto* client = static_cast<Connection*>(handle->data);

		if (client->read > 0) {
			buf->len = 1024 - client->read;
			buf->base = client->frame.get_buffer() + client->read;
		}

		buf->base = client->frame.get_buffer();
		buf->len = 1024;
	}

	void on_read(uv_stream_t *stream, ssize_t nread, const uv_buf_t* _) {
		auto* client = static_cast<ZeonAPI::Connection*>(stream->data);
		if (nread == UV_EOF) {
			uv_stop(&client->loop);
			uv_read_stop(stream);
			return;
		}

		if (nread > 0) {
			client->read += nread;

			if (client->read == 1024) {
				client->frame.from_buffer();
				handle_frame(client, stream);
			}
		} else if (nread == 0) {
		} else {
			fprintf(stderr, "Something went wrong! %s\n", uv_strerror((int) nread));
			uv_stop(&client->loop);
			client->connected = false;
		}
	}

	void handle_frame(ZeonAPI::Connection *client, uv_stream_t *stream) {
		client->read = 0;
		switch (client->frame.get_status()) {
			case ZeonFrameStatus::Ok:
				uv_read_stop(stream);
				break;
			case ZeonFrameStatus::Auth:
			{
				auto buff = client->frame.read_buffer();
				uv_read_stop(stream);
				memset(buff.data() + client->frame.get_length(), 0, 1015 - client->frame.get_length());

				if (memcmp(buff.data(), "OK", 2) == 0) {
					client->authenticated = true;
				} else {
					client->error = buff.data();
				}
				break;
			}
			case ZeonFrameStatus::Error:
			{
				auto buff = client->frame.read_buffer();
				memset(buff.data() + client->frame.get_length(), 0, 1015 - client->frame.get_length());
				uv_read_stop(stream);

				client->error = buff.data();
				break;
			}
			case ZeonFrameStatus::Command:
			{
				auto buff = client->frame.read_buffer();
				memset(buff.data() + client->frame.get_length(), 0, 1015 - client->frame.get_length());
				uv_read_stop(stream);

				client->buffer = buff.data();
				break;
			}
			default:
				break;
		}
	}
}
