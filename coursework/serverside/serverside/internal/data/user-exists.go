package data

import "fmt"

// checks if the passed in username exists in the database
// in case a stored hashed passcode is available for the user --> meaning username exists
// the user has to now register with new username.
func UserExists(username string) bool {
	_, exists := StoredUserPc(username)

	if exists {
		fmt.Println("Username", username, " exists in the database")
	}

	return exists
}
