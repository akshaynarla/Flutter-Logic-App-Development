package main

import (
	"log"
	"net/http"
)

// STEP 7: Dummy function for returning some value when the app is running or server is running.
/* moved this block in Step 12
type InMemoryPlayerStore struct{}

/ STEP 10: addition
func (i *InMemoryPlayerStore) RecordWin(name string) {}

func (i *InMemoryPlayerStore) GetPlayerScore(name string) int {
	return 123
}*/

func main() {
	// Server handler. Implements the server
	// Typically done by creating a struct and interfaces for ServeHTTP method
	// --> handled already with the HandlerFunc
	// handler := http.HandlerFunc(PlayerServer)

	// The above code is now embedded onto NewPlayerServer
	server := NewPlayerServer(NewInMemoryPlayerStore())
	// Listens on a port the parsed handler/server.
	// Wrapped with log.Fatal to log errors in case server doesn't return.
	log.Fatal(http.ListenAndServe(":5000", server))
}
