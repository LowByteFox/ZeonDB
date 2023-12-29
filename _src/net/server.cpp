#include <cstdint>
#include <cstdio>

#include <db.hpp>
#include <uv.h>
#include <net/server.hpp>

void on_connect(uv_stream_t *server, int status) {
	printf("%p\n", server->data);
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
