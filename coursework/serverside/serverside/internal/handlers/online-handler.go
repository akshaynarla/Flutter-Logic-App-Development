package handlers

import "net/http"

// returns init message of server on get request
// verifies if server is running or not (indirect checking of online or offline)
func OnlineHandler(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case "GET":
		w.WriteHeader(http.StatusOK)
		w.Write([]byte("Server is serving!!"))
	}
}
