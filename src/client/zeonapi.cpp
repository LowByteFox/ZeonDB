#include <client/zeonapi.hpp>

#include <cmath>
#include <cstdio>
#include <cstring>
#include <cstdint>
#include <string>
#include <vector>

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
	void alloc_header(uv_handle_t*, size_t, uv_buf_t*);
	void alloc_transfer(uv_handle_t*, size_t, uv_buf_t*);
	void get_frame(uv_stream_t *, ssize_t, const uv_buf_t*);
	void transfer_buffer(uv_stream_t *handle, ssize_t nread, const uv_buf_t *buf);
	void handle_frame(ZeonAPI::Connection *client, uv_stream_t *stream);

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
		uv_read_start((uv_stream_t*) &this->tcp, alloc_header, get_frame);
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

		this->send_message(msg, ZeonFrameStatus::Auth);
		uv_read_start((uv_stream_t*) &this->tcp, alloc_header, get_frame);
		uv_run(&this->loop, UV_RUN_DEFAULT);

		return this->authenticated;
	}

	bool Connection::exec(std::string command) {
		this->error = "";
		this->buffer = "";

		this->send_message(command, ZeonFrameStatus::Command);
		uv_read_start((uv_stream_t*) &this->tcp, alloc_header, get_frame);
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

	void Connection::send_message(std::string buf, ZeonFrameStatus status) {
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
			vec.push_back(uv_buf_init(back_ref.data(), back_ref.length()));
		}

		uv_write_t* req = new uv_write_t;
		uv_write(req, (uv_stream_t*) &this->tcp, vec.data(), vec.size(), send_msg);
	}

	void alloc_header(uv_handle_t *handle, size_t _, uv_buf_t *buf) {
		auto* conn = static_cast<Connection*>(handle->data);

		if (conn->read > 0) {
			buf->len = 9 - conn->read;
			buf->base = conn->frame.get_buffer() + conn->read;
			return;
		}

		buf->base = conn->frame.get_buffer();
		buf->len = 9;
	}

	void alloc_transfer(uv_handle_t *handle, size_t _, uv_buf_t *buf) {
		auto* conn = static_cast<Connection*>(handle->data);

		buf->base = conn->transfer_buffer.data();
		buf->len = 1024;
	}
	
	void get_frame(uv_stream_t *stream, ssize_t nread, const uv_buf_t* buf) {
		auto* conn = static_cast<Connection*>(stream->data);

		if (nread == UV_EOF) {
			uv_stop(&conn->loop);
			uv_read_stop(stream);
			return;
		}

		if (nread > 0) {
			conn->read += nread;

			if (conn->read == 9) {
				conn->frame.from_buffer();
				conn->transfer_max = conn->frame.get_length();
				conn->read = 0;
				if (conn->transfer_max > 0) {
					uv_read_stop(stream);
					uv_read_start((uv_stream_t*) &conn->tcp, alloc_transfer, transfer_buffer);
				} else {
					handle_frame(conn, stream);
				}
			}
		} else if (nread == 0) {
		} else {
			fprintf(stderr, "Something went wrong! %s\n", uv_strerror((int) nread));
			uv_stop(&conn->loop);
			uv_read_stop(stream);
			conn->connected = false;
		}
	}

	void transfer_buffer(uv_stream_t *handle, ssize_t nread, const uv_buf_t *buf) {
		auto* conn = static_cast<Connection*>(handle->data);

		if (nread == UV_EOF) {
			uv_stop(&conn->loop);
			uv_read_stop(handle);
			return;
		}

		if (nread > 0) {
			conn->transfer_max -= nread;
			conn->buffer += std::string(conn->transfer_buffer.data(), nread);

			if (conn->transfer_max <= 0) {
				uv_read_stop(handle);
				uv_read_start((uv_stream_t*) &conn->tcp, alloc_header, get_frame);
				handle_frame(conn, handle);
			}
		} else if (nread == 0) {
		} else {
			fprintf(stderr, "Something went wrong! %s\n", uv_strerror((int) nread));
			uv_stop(&conn->loop);
		}
	}

	void handle_frame(ZeonAPI::Connection *client, uv_stream_t *stream) {
		uv_read_stop(stream);
		switch (client->frame.get_status()) {
			case ZeonFrameStatus::Auth:
			{
				std::string buff = client->buffer;

				if (memcmp(buff.data(), "OK", 2) == 0) {
					client->authenticated = true;
				} else {
					client->error = buff;
				}
				break;
			}
			case ZeonFrameStatus::Error:
			{
				std::string buff = client->buffer;

				client->error = buff;
				break;
			}
			default:
				break;
		}
	}
}
