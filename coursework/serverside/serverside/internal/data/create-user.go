package data

import (
	"fmt"
	"serverside/internal/common"
	"serverside/internal/crypt"
)

// CreateUser creates a new user in the database --> useful for registering user
func CreateUser(username, password string) error {

	// Store the username and the corresponding hashed password in the database
	sqlStr := `INSERT INTO user(username, passcode) VALUES (?, ?)`
	_, err := common.Database.Exec(sqlStr, username, crypt.GetHash(password))
	if err != nil {
		return fmt.Errorf("User creation failed in database:%v", err)
	}
	return nil
}
