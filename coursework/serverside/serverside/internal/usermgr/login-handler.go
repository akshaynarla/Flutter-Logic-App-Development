package usermgr

import (
	"encoding/json"
	"fmt"
	"net/http"
	"serverside/internal/crypt"
	"serverside/internal/data"
	"time"

	"github.com/google/uuid"
)

// inspired from: https://dev.to/theghostmac/understanding-and-building-authentication-sessions-in-golang-1c9k
// similar to: https://www.sohamkamani.com/golang/session-cookie-authentication
// checks if user is registered on the database and logs in to the user quiz session
// session token is generated for user for the logged in session --> valid for 80 minutes after which session is invalid
// and the user has to login again
func LoginHandler(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case "POST":
		var user_credential data.UserCredentials

		// Get the JSON body and decode into credentials
		err := json.NewDecoder(r.Body).Decode(&user_credential)
		if err != nil {
			// response body incorrect, return an HTTP error
			w.WriteHeader(http.StatusBadRequest)
			fmt.Println("User data decoding failed during login")
			return
		}
		// returns stored passcode of the user
		actualHashPasscode, ok := data.StoredUserPc(user_credential.Username)

		// If calculated hash for the given passcode is different to the stored passcode hash,
		// send an unauthorized status ==> wrong passcode given by user
		if !ok || !crypt.CheckHash(actualHashPasscode, user_credential.Passcode) {
			w.WriteHeader(http.StatusUnauthorized)
			fmt.Println("User passcode entered is wrong")
			return
		}

		// Create a new session instance for the user in case of passcode match
		// Reference for time handling: https://blog.boot.dev/golang/golang-date-time/
		session := data.Session{
			Username: user_credential.Username,
			Expiry:   time.Now().Local().Add(time.Minute * 80),
		}
		fmt.Println("Session is:", session)
		// Generate a UUID Token for the corresponding user with session information
		sessionToken := uuid.NewString()

		// anonymous tracking of user session in database --> available in admin HTML
		data.AnonymTracking(sessionToken, session)

		// set cookie in the http response
		http.SetCookie(w, &http.Cookie{
			Name:    "session_token",
			Value:   sessionToken,
			Expires: session.Expiry,
		})

		// Send successful login message
		w.WriteHeader(http.StatusOK)
		w.Write([]byte("User log in success.."))
	}
}
