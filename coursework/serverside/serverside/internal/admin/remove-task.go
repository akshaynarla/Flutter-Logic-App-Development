package admin

import (
	"fmt"
	"net/http"
	"serverside/internal/data"
)

// returns init message of server on get request
// user-management modified from: https://github.com/zjhnb11/logic_quiz_App
func RemoveTask(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case "POST":
		err := r.ParseForm()
		if err != nil {
			http.Error(w, "Unable to parse form", http.StatusBadRequest)
			return
		}
		// returns the task id
		taskID := r.FormValue("id")

		err = data.DeleteTask(taskID)
		if err != nil {
			http.Error(w, "removal of task failed in database", http.StatusInternalServerError)
			return
		}

		fmt.Fprintf(w, "Task successfully removed")
	}
}
