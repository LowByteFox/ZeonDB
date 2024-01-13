package main

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
