#ifndef ZEONAPI_H
#define ZEONAPI_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

// Forward declaration of opaque pointer to the Connection class
typedef struct ZeonAPI_Connection ZeonAPI_Connection;

// Function declarations for creating and destroying Connection objects
ZeonAPI_Connection* ZeonAPI_Connection_create(const char* host, uint16_t port);
void ZeonAPI_Connection_destroy(ZeonAPI_Connection* connection);

// Function declarations for other methods
int ZeonAPI_Connection_is_up(ZeonAPI_Connection* connection);
const char* ZeonAPI_Connection_get_error(ZeonAPI_Connection* connection);
const char* ZeonAPI_Connection_get_buffer(ZeonAPI_Connection* connection);
int ZeonAPI_Connection_auth(ZeonAPI_Connection* connection, const char* username, const char* password);
int ZeonAPI_Connection_exec(ZeonAPI_Connection* connection, const char* command);

#ifdef __cplusplus
}
#endif

#endif // ZEONAPI_H
