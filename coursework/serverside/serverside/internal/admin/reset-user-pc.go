package admin

import (
	"fmt"
	"net/http"
	"serverside/internal/data"
)

// resets suer passcode in the database --> this is for admin to reset passcode from HTML
func ResetUserPc(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case "POST":
		username := r.FormValue("resetUsername")
		newPassword := r.FormValue("newPasscode")

		err := data.UpdatePasscode(username, newPassword)
		if err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			return
		}

		w.WriteHeader(http.StatusOK)
		fmt.Fprintf(w, "successfully reset passcode for user %s", username)
	}
}
