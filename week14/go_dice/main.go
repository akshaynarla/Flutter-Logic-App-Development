package main

import (
	"fmt"
	"net/http"
)

func main() {
	// initializing 10 dice pairs for the server
	for i := 0; i < 10; i++ {
		dicePairs = append(dicePairs, NewDicePair())
	}

	// defining mux routes based on http package and the
	router := http.NewServeMux()
	// path followed by the handler function when the http request has the parsed path format
	router.HandleFunc("/dice/", diceHandler)
	router.HandleFunc("/statistics/", statsHandler)
	router.HandleFunc("/reset/", resetHandler)

	fmt.Printf("Server is running on port 8080\n")
	// Listen to the server "router" on port 8080
	http.ListenAndServe(":8080", router)
}
