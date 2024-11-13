package data

import (
	"fmt"
	"serverside/internal/common"
)

// Delete task data from database
func DeleteTask(taskID string) error {
	sqlStr := `DELETE FROM tasks WHERE task_id = ?`
	_, err := common.Database.Exec(sqlStr, taskID)
	if err != nil {
		return fmt.Errorf("couldn't remove task from database, err:%v", err)
	}
	return nil
}
