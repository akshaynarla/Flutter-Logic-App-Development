package data

import (
	"fmt"
	"serverside/internal/common"
)

// CreateUserStats creates a new user in the stats database --> useful for storing user stats
// This is done when the user first registers --> allows for later data storage and persistence
func CreateUserStats(username string) error {

	sqlStr := `INSERT INTO user_stats(username, score, mode, sessions) VALUES (?, 0, ?, 0)`

	// prepare the SQL insertion statement --> any error in sql query statement can be caught --> mainly done for debugging
	stmt, err := common.Database.Prepare(sqlStr)
	if err != nil {
		return fmt.Errorf("failed to prepare statement: %v", err)
	}
	defer stmt.Close()

	// initialize the first row for "normal" mode
	_, err = stmt.Exec(username, "normal")
	if err != nil {
		return fmt.Errorf("failed to insert user stats for normal mode: %v", err)
	}

	// initialize the second row for "timed" mode
	_, err = stmt.Exec(username, "timed")
	if err != nil {
		return fmt.Errorf("failed to insert user stats for timed mode: %v", err)
	}

	return nil
}
