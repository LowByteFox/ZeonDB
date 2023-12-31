#include <cstdio>
#include <iostream>
#include <string>

#include <client/zeonapi.hpp>

int main() {
	ZeonAPI::Connection zeon("127.0.0.1", 6748);

	std::string username;
	std::string password;

	printf("Username: ");
	std::getline(std::cin, username);
	printf("Password: ");
	std::getline(std::cin, password);

	if (zeon.auth(username, password)) {
		while (true) {
			printf("(%s@127.0.0.1)> ", username.c_str());
			std::string cmd;
			std::getline(std::cin, cmd);

			if (cmd.compare("exit") == 0) {
				break;
			}

			if (!zeon.exec(cmd)) {
				printf("%s\n", zeon.get_error().c_str());
			} else {
				printf("%s\n", zeon.get_buffer().c_str());
			}
		}
	} else {
		fprintf(stderr, "Could not login! %s\n", zeon.get_error().c_str());
	}
}
