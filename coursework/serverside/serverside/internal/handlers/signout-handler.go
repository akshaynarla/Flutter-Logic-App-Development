package handlers

import (
	"fmt"
	"net/http"
	"serverside/internal/data"
	"time"
)

// sign out user from server on post request
func SignoutHandler(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case "POST":
		c, err := r.Cookie("session_token")

		if err != nil {
			if err == http.ErrNoCookie {
				// If the cookie is not set, return an unauthorized status
				fmt.Println("Cookie Not Set")
				w.WriteHeader(http.StatusUnauthorized)
				return
			}
			// For any other type of error, return a bad request status
			w.WriteHeader(http.StatusBadRequest)
			return
		}
		sessionToken := c.Value
		fmt.Println("Session Token:", sessionToken, "value")

		// delete token data from tracking --> session is not valid anymore
		data.DeleteTracking(sessionToken)

		http.SetCookie(w, &http.Cookie{
			Name:    "session_token",
			Value:   "",
			Expires: time.Now(),
		})
		w.WriteHeader(http.StatusOK)
	}
}
