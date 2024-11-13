package usermgr

import (
	"encoding/json"
	"fmt"
	"net/http"
	"serverside/internal/data"
)

// checks if user is registered on the database and logs in to the user quiz session
// reference and inspired from: https://www.sohamkamani.com/golang/password-authentication-and-storage/
func RegisterHandler(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case "POST":
		var req data.UserRegistration
		err := json.NewDecoder(r.Body).Decode(&req)
		if err != nil {
			w.WriteHeader(http.StatusBadRequest)
			fmt.Println("Error in json decoding during registration")
			return
		}
		// Create user in Database only if the corresponding username doesn't already exist
		if !data.UserExists(req.Username) {
			err = data.CreateUser(req.Username, req.Passcode)
			if err != nil {
				w.WriteHeader(http.StatusInternalServerError)
				fmt.Println("User creation failed during registration")
				return
			}

			// create user in stats table as well by initializing it to default values
			err = data.CreateUserStats(req.Username)
			if err != nil {
				w.WriteHeader(http.StatusInternalServerError)
				fmt.Println("User stats creation failed during registration")
				return
			}

			// If the user name is valid, write a message
			w.WriteHeader(http.StatusOK)
			w.Write([]byte("User registered successfully!"))
		} else {
			// if username already exists in the database
			w.WriteHeader(http.StatusBadRequest)
			return
		}

	}
}
