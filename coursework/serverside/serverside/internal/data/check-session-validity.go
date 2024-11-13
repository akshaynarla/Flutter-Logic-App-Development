package data

import (
	"fmt"
	"log"
	"serverside/internal/common"
	"time"
)

// https://www.sohamkamani.com/golang/session-cookie-authentication/#authenticating-users-through-session-cookies
// chcek the supplied session token from the sessions table of database to verify if the current session is valid
func CheckSessionValidity(sessionToken string) (sessionData Session, exists bool) {
	var currentSessionToken string
	sessionRow, err := common.Database.Query("select * from sessions where token='" + sessionToken + "'")
	if err != nil {
		log.Fatal(err)
	}
	defer sessionRow.Close()

	var sessionExpiryDatabase time.Time
	var sessionUsername string = ""

	for sessionRow.Next() {
		err := sessionRow.Scan(&sessionUsername, &currentSessionToken, &sessionExpiryDatabase)
		if err != nil {
			fmt.Println("session check error", err.Error())
		}
	}

	if currentSessionToken != "" {
		// session exists for the user in database with same session token
		exists = true
		sessionData = Session{Username: sessionUsername, Token: currentSessionToken, Expiry: sessionExpiryDatabase}
	} else {
		exists = false
	}

	return sessionData, exists
}
