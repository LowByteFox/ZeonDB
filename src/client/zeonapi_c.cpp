#include <cstdint>

#include "client/zeonapi.h"
#include "client/zeonapi.hpp"  // Assuming this is the header file for the ZeonAPI::Connection class

extern "C" {

ZeonAPI_Connection* ZeonAPI_Connection_create(const char* host, uint16_t port) {
    return (ZeonAPI_Connection*)new ZeonAPI::Connection(host, port);
}

void ZeonAPI_Connection_destroy(ZeonAPI_Connection* connection) {
    delete ((ZeonAPI::Connection*)connection);
}

int ZeonAPI_Connection_is_up(ZeonAPI_Connection* connection) {
    if (connection) {
        return ((ZeonAPI::Connection*)connection)->is_up();
    }
    return 0;  // Return false if the connection pointer is null
}

const char* ZeonAPI_Connection_get_error(ZeonAPI_Connection* connection) {
    if (connection) {
        return ((ZeonAPI::Connection*)connection)->get_error()->c_str();
    }
    return nullptr;  // Return nullptr if the connection pointer is null
}

const char* ZeonAPI_Connection_get_buffer(ZeonAPI_Connection* connection) {
    if (connection) {
        return ((ZeonAPI::Connection*)connection)->get_buffer()->c_str();
    }
    return nullptr;  // Return nullptr if the connection pointer is null
}

int ZeonAPI_Connection_auth(ZeonAPI_Connection* connection, const char* username, const char* password) {
    if (connection) {
        return ((ZeonAPI::Connection*)connection)->auth(username, password);
    }
    return 0;  // Return false if the connection pointer is null
}

int ZeonAPI_Connection_exec(ZeonAPI_Connection* connection, const char* command) {
    if (connection) {
        return ((ZeonAPI::Connection*)connection)->exec(command);
    }
    return 0;  // Return false if the connection pointer is null
}

}  // extern "C"
