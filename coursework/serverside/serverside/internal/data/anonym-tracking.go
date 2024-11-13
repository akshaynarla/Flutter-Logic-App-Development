package data

import (
	"fmt"
	"serverside/internal/common"
)

// anonymous tracking of sessions for admin usage
// add the user session data to database
func AnonymTracking(sessionToken string, session Session) {
	stmt, err := common.Database.Prepare("INSERT INTO sessions (token, username, expiresAt) VALUES (?, ?, ?)")
	if err != nil {
		fmt.Println("Error preparing SQL statement:", err.Error())
		return
	}
	defer stmt.Close()

	_, err = stmt.Exec(sessionToken, session.Username, session.Expiry)
	if err != nil {
		fmt.Println("Anonymous tracking error:", err.Error())
	}
}
