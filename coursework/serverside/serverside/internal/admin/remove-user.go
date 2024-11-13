package admin

import (
	"fmt"
	"log"
	"net/http"
	"serverside/internal/common"
	"serverside/internal/data"
)

// method to remove user from the database --> also remove stats from the database.
// first delete user from user_stats since the primary key is dependent on user.
// Composite key used here to maintain uniqueness of users. Only users in user table
// can be created in user_stats or deleted in user_stats.
func RemoveUser(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case "POST":
		username := r.FormValue("removeUsername")
		// remove user from user_stats table first
		stErr := data.DeleteUserStats(username)
		if stErr != nil {
			fmt.Println("User stat deletion failed")
			w.WriteHeader(http.StatusInternalServerError)
			return
		}
		// only when user_stats data is deleted for the user, the user can be deleted from user table
		sqlStr := `DELETE FROM user WHERE username = ?`

		stmt, err := common.Database.Prepare(sqlStr)
		if err != nil {

			w.WriteHeader(http.StatusInternalServerError)
			fmt.Fprintf(w, "Server Error")
			return
		}
		defer stmt.Close()

		_, err = stmt.Exec(username)

		if err != nil {
			log.Printf("Error preparing statement: %v", err)
			w.WriteHeader(http.StatusInternalServerError)
			fmt.Fprintf(w, "Server Error")
			return
		}

		w.WriteHeader(http.StatusOK)
		fmt.Fprintf(w, "successfully removed user %s", username)
	}
}
