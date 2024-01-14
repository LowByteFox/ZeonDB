package main

/*
#cgo CFLAGS: -I../src/include/client
#cgo LDFLAGS: -L/usr/local/lib -L../build -lZeonCAPI -lc++abi -lc++ -luv -lssl -lcrypto
#include <zeonapi.h>
*/
import "C"

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"github.com/gorilla/websocket"
	"net/http"
)

var upgrader = websocket.Upgrader{
	CheckOrigin: func(r *http.Request) bool {
		return true
	},
}

func main() {
	gin.SetMode(gin.ReleaseMode)
	r := gin.Default()

	connection := C.ZeonAPI_Connection_create(C.CString("127.0.0.1"), C.uint16_t(6748))
	defer C.ZeonAPI_Connection_destroy(connection)

	if (C.ZeonAPI_Connection_auth(connection, C.CString("theo"), C.CString("paris")) == 1) {
		if (C.ZeonAPI_Connection_exec(connection, C.CString("get $")) == 0) {
			fmt.Println(""+C.GoString(C.ZeonAPI_Connection_get_error(connection)));
		} else {
			fmt.Println(""+C.GoString(C.ZeonAPI_Connection_get_buffer(connection)));
		}
	} else {
		fmt.Printf("Could not login! %s\n", C.ZeonAPI_Connection_get_error(connection));
	}

	r.StaticFile("/", "./index.html")
	r.StaticFile("/litegraph.js", "./litegraph.js")
	r.StaticFile("/litegraph.css", "./litegraph.css")

	r.GET("/ws", func(c *gin.Context) {
		conn, err := upgrader.Upgrade(c.Writer, c.Request, nil)
		if err != nil {
			fmt.Println(err)
			return
		}
		defer conn.Close()

		for {
			messageType, p, err := conn.ReadMessage()
			if err != nil {
				fmt.Println(err)
				return
			}

			err = conn.WriteMessage(messageType, p)
			if err != nil {
				fmt.Println(err)
				return
			}
		}
	})

	fmt.Println("ZeonUI has started at port 8080!")
	r.Run(":8080")
}
