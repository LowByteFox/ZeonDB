package main

/*
#cgo CFLAGS: -I../src/include/client
#cgo LDFLAGS: -L/usr/local/lib -L../build -lZeonCAPI -lc++abi -lc++ -luv -lssl -lcrypto
#include <zeonapi.h>
*/
import "C"

import (
	"fmt"
	"encoding/json"
	"github.com/gin-gonic/gin"
	"github.com/gorilla/websocket"
	"net/http"
)

func parseJSON(jsonString string) (map[string]interface{}, error) {
	var result map[string]interface{}
	err := json.Unmarshal([]byte(jsonString), &result)
	if err != nil {
		return nil, err
	}
	return result, nil
}

func toJSON(data map[string]interface{}) (string, error) {
	jsonBytes, err := json.Marshal(data)
	if err != nil {
		return "", err
	}
	return string(jsonBytes), nil
}

var upgrader = websocket.Upgrader{
	CheckOrigin: func(r *http.Request) bool {
		return true
	},
}

func main() {
	gin.SetMode(gin.ReleaseMode)
	r := gin.Default()

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

		zeon := C.ZeonAPI_Connection_create(C.CString("127.0.0.1"), C.uint16_t(6748))
		defer C.ZeonAPI_Connection_destroy(zeon);
		C.ZeonAPI_Connection_auth(zeon, C.CString("theo"), C.CString("paris")) 

		for {
			msgType, p, err := conn.ReadMessage()
			if err != nil {
				fmt.Println(err)
				return
			}

			parsedJSON, err := parseJSON(string(p[:]));
			if err != nil {
				fmt.Println(err)
				return
			}

			typ := parsedJSON["type"];
			code := parsedJSON["code"].(string);

			res := C.ZeonAPI_Connection_exec(zeon, C.CString(code));
			if (res == 1) { // everything is ok
				result := map[string]interface{} {
					"type":   typ,
					"ok":   true,
					"value": string(C.GoString(C.ZeonAPI_Connection_get_buffer(zeon))),
				}

				str, _ := toJSON(result);

				err = conn.WriteMessage(msgType, []byte(str))
				if err != nil {
					fmt.Println(err)
					return
				}
			} else {
				result := map[string]interface{} {
					"type":   typ,
					"ok":   false,
					"value": string(C.GoString(C.ZeonAPI_Connection_get_error(zeon))),
				}

				str, _ := toJSON(result);

				err = conn.WriteMessage(msgType, []byte(str))
				if err != nil {
					fmt.Println(err)
					return
				}
			}

			// on execution return this json
			// {
			//   type: type,
			//	 ok: bool, // if error false, else true
			//	 value: ...
			// }
		}
	})

	fmt.Println("ZeonUI has started at port 8080!")
	r.Run(":8080")
}
