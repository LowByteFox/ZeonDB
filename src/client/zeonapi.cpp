#include <client/zeonapi.hpp>

#include <cmath>
#include <cstdio>
#include <cstring>
#include <cstdint>
#include <string>
#include <vector>
#include <queue>

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

#define SPLIT_SIZE 8192

#ifndef MIN
#define MIN(a, b) ((a) < (b) ? (a) : (b))
#endif

namespace ZeonAPI {
    struct IdleData {
        std::queue<std::string> *strs;
        uv_tcp_t *conn;
    };

	void alloc_buffer(uv_handle_t*, size_t, uv_buf_t*);
	void get_frame(uv_stream_t *, ssize_t, const uv_buf_t*);
	void transfer_buffer(uv_stream_t *handle, ssize_t nread, const uv_buf_t *buf);
	void handle_frame(ZeonAPI::Connection *client, uv_stream_t *stream);

	Connection::Connection(std::string ip, uint16_t port) {
		this->header_parsed = false;
		this->authenticated = false;
		this->connected = false;
        this->read = 0;

		uv_loop_init(&this->loop);

		uv_ip4_addr(ip.c_str(), port, &this->addr);
		uv_tcp_init(&this->loop, &this->tcp);
		uv_tcp_connect(&this->conn, &this->tcp, (const struct sockaddr*)&this->addr, on_connect);
		
		this->tcp.data = this;

		uv_run(&this->loop, UV_RUN_ONCE); // Debilny windows sprosty
		uv_read_start((uv_stream_t*) &this->tcp, alloc_buffer, get_frame);
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
		msg.append((char *) out, SHA256_DIGEST_LENGTH);

		this->error = "";
		this->buffer = "";
		this->send_message(msg, ZeonFrameStatus::Auth);
		uv_read_start((uv_stream_t*) &this->tcp, alloc_buffer, get_frame);
		uv_run(&this->loop, UV_RUN_DEFAULT);

		return this->authenticated;
	}

	bool Connection::exec(std::string command) {
		this->error = "";
		this->buffer = "";

		this->send_message(command, ZeonFrameStatus::Command);
		uv_read_start((uv_stream_t*) &this->tcp, alloc_buffer, get_frame);
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

    void send_data(uv_idle_t* handle) {
        auto data = (IdleData*) handle->data;
        
		uv_write_t* req = new uv_write_t;
        uv_buf_t buf = uv_buf_init(data->strs->front().data(), data->strs->front().length());
		uv_write(req, (uv_stream_t*) data->conn, &buf, 1, send_msg);
        data->strs->pop();

        if (data->strs->empty()) {
            uv_idle_stop(handle);
            delete data->strs;
            delete data;
            delete handle;
        }
    }

	void Connection::send_message(std::string buf, ZeonFrameStatus status) {
		size_t len = buf.length();

		this->frame.to_buffer(status, len);

		auto strs = new std::queue<std::string>();

		for (int i = 0; i < len || i == 0; i += SPLIT_SIZE) {
            size_t end = MIN(i + SPLIT_SIZE, len);
			strs->push(buf.substr(i, end - i));

			if (i == 0) {
				char *frame_buffer = this->frame.get_buffer();
				std::string first_packet(9 + (status == ZeonFrameStatus::Ok ? 0 : SPLIT_SIZE), 0);
				
				memcpy(first_packet.data(), frame_buffer, 9);

				if (status != ZeonFrameStatus::Ok) {
					std::string& back_ref = strs->back();
					memcpy(first_packet.data() + 9, back_ref.data(), back_ref.length());
                }

                strs->pop();
                strs->push(first_packet);
				continue;
			}
		}

		uv_write_t* req = new uv_write_t;
        uv_buf_t outbuf = uv_buf_init(strs->front().data(), strs->front().length());
		uv_write(req, (uv_stream_t*) &this->tcp, &outbuf, 1, send_msg);
        strs->pop();

        if (!strs->empty()) {
            uv_idle_t* idle_handle = new uv_idle_t;
            auto data = new IdleData;
            data->strs = strs;
            data->conn = &this->tcp;

            idle_handle->data = data;
            uv_idle_init(&this->loop, idle_handle);
            uv_idle_start(idle_handle, send_data);
        }
	}

	void alloc_buffer(uv_handle_t *handle, size_t suggest, uv_buf_t *buf) {
		auto* conn = static_cast<Connection*>(handle->data);
        conn->buffer.resize(conn->buffer.size() + suggest);

		buf->base = conn->buffer.data() + conn->read;
		buf->len = suggest;
	}

	void get_frame(uv_stream_t *stream, ssize_t nread, const uv_buf_t* buf) {
		auto* conn = static_cast<Connection*>(stream->data);

        if (nread == UV_EOF) {
            uv_read_stop(stream);
            uv_stop(&conn->loop);
            return;
        }

		if (nread > 0) {
			if (conn->buffer.size() >= 9) {
                if (!conn->header_parsed) {
                    char *buff = conn->frame.get_buffer();
                    memcpy(buff, conn->buffer.data(), 9);
        			conn->frame.from_buffer();
        			conn->transfer_max = conn->frame.get_length() - nread + 9;
                    conn->header_parsed = true;
                    conn->read = nread;
                } else {
        			conn->transfer_max -= nread;
                    conn->read += nread;
                }

	    		if (conn->transfer_max <= 0) {
                    conn->buffer.resize(conn->read);
    				handle_frame(conn, stream);
    			}
			}
        } else if (nread == 0) {
		} else {
			fprintf(stderr, "Something went wrong! %s\n", uv_strerror((int) nread));
			uv_stop(&conn->loop);
			conn->connected = false;
		}
	}

	void handle_frame(ZeonAPI::Connection *client, uv_stream_t *stream) {
        uv_read_stop(stream);
		uv_stop(&client->loop);
		switch (client->frame.get_status()) {
			case ZeonFrameStatus::Auth:
			{
				std::string buff = client->buffer.data() + 9;

				if (memcmp(buff.data(), "OK", 2) == 0) {
					client->authenticated = true;
				} else {
					client->error = buff;
				}
				break;
			}
			case ZeonFrameStatus::Error:
			{
				std::string buff = client->buffer.data() + 9;

				client->error = buff;
				break;
			}
			default:
				break;
		}

        client->header_parsed = false;
	    client->buffer = "";
        client->read = 0;
	}
}
