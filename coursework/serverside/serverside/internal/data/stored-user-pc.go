package data

import (
	"fmt"
	"serverside/internal/common"
)

// checks for stored passcode of the parsed user and returns it
func StoredUserPc(storedUsername string) (storedHashPc string, isExists bool) {
	// scan the database for the username parsed and scan for corresponding stored passcode
	sqlQuery := "SELECT `passcode` FROM `user` WHERE `username` = ?"
	err := common.Database.QueryRow(sqlQuery, storedUsername).Scan(&storedHashPc)
	if err != nil {
		fmt.Println(err)
	}

	// isExists  --> to check if hashed passcode exists for the given user (i.e., if an account is created)
	// means that the username is already in use --> helps in identifying duplicate usernames
	if storedHashPc != "" {
		isExists = true
	} else {
		isExists = false
	}

	return storedHashPc, isExists
}
