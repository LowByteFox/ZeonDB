#include <uv.h>
#include <memory>
#include <queue>
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

#define SPLIT_SIZE 8192

#ifndef MIN
#define MIN(a, b) ((a) < (b) ? (a) : (b))
#endif

namespace ZeonDB::Net {
    struct IdleData {
        std::queue<std::string> *strs;
        uv_tcp_t *conn;
    };

	Client::Client(Server *server, uv_tcp_t connection) {
		this->server = server;
		this->client = connection;
        this->read = 0;
		this->transfer_max = 0;
        this->header_parsed = false;
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

	void Client::send_message(std::string buf, ZeonFrameStatus status) {
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
		uv_write(req, (uv_stream_t*) &this->client, &outbuf, 1, send_msg);
        strs->pop();

        if (!strs->empty()) {
            uv_idle_t* idle_handle = new uv_idle_t;
            auto data = new IdleData;
            data->strs = strs;
            data->conn = &this->client;

            idle_handle->data = data;
            uv_idle_init(this->server->get_loop(), idle_handle);
            uv_idle_start(idle_handle, send_data);
        }
	}
}
