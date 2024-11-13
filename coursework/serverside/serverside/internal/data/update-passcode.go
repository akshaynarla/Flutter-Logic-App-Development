package data

import (
	"fmt"
	"serverside/internal/common"
	"serverside/internal/crypt"
)

// Inspired from: https://github.com/zjhnb11/logic_quiz_App
// UpdatePasscode is used for resetting the user passcode
func UpdatePasscode(username, new_passcode string) error {

	// search for username and update the corresponding hashed password in the database
	sqlStr := `UPDATE user SET passcode = ? WHERE username = ?`
	_, err := common.Database.Exec(sqlStr, crypt.GetHash(new_passcode), username)
	if err != nil {
		return fmt.Errorf("passcode update failed in database:%v", err)
	}
	return nil
}
