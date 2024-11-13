package data

import (
	"fmt"
	"serverside/internal/common"
)

// delete tracking of sessions
func DeleteTracking(sessionToken string) {
	stmt := "delete from sessions where token='" + sessionToken + "'"
	_, errIn := common.Database.Exec(stmt)

	if errIn != nil {
		fmt.Println("tracking data delete error", errIn.Error())
	}
}
