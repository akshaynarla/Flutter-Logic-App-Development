package usermgr

import (
	"encoding/json"
	"fmt"
	"net/http"
	"serverside/internal/data"
)

// resets passcode of the user in the database
func ResetpcHandler(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case "POST":
		var req data.ResetUserPasscode
		err := json.NewDecoder(r.Body).Decode(&req)
		if err != nil {
			w.WriteHeader(http.StatusBadRequest)
			fmt.Println("User passcode reset failed due to json decoding")
			return
		}

		// Update passcode in user database
		err = data.UpdatePasscode(req.Username, req.NewPasscode)
		if err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			fmt.Println("User passcode reset failed in server")
			return
		}

		w.WriteHeader(http.StatusOK)
	}
}
