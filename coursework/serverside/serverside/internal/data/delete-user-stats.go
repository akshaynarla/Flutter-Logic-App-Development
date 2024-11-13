package data

import (
	"fmt"
	"serverside/internal/common"
)

// deletes the user statas from the stats table --> done when the user is removed.
func DeleteUserStats(username string) error {
	sqlStr := `DELETE FROM user_stats WHERE username = ?`

	// Prepare the SQL statement
	stmt, err := common.Database.Prepare(sqlStr)
	if err != nil {
		return fmt.Errorf("failed to prepare statement for deletion: %v", err)
	}
	defer stmt.Close()

	_, err = stmt.Exec(username)
	if err != nil {
		return fmt.Errorf("failed to delete user stats: %v", err)
	}

	return nil
}
