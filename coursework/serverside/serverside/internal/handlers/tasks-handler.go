package handlers

import (
	"encoding/json"
	"fmt"
	"net/http"
	"serverside/internal/common"
	"serverside/internal/data"
	"time"
)

// similar to: https://github.com/zjhnb11/logic_quiz_App
// returns tasks from server/database on get request
// use of database now allows for the latest status of tasks available to the front-end
// (maybe admin added few new tasks via the admin HTML interface or deleted few tasks from database)
func TasksHandler(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case "GET":
		// check if user is making request with valid cookies
		cookieVal, err := r.Cookie("session_token")
		if err != nil {
			if err == http.ErrNoCookie {
				w.WriteHeader(http.StatusUnauthorized)
				fmt.Println("No cookies for tasks")
				return
			}
			w.WriteHeader(http.StatusBadRequest)
			return
		}
		sessionToken := cookieVal.Value
		// check if user already has a running session with same token
		userSession, exists := data.CheckSessionValidity(sessionToken)
		if !exists {
			fmt.Println("Tasks session Not Valid in CheckSessionValidity")
			w.WriteHeader(http.StatusUnauthorized)
			return
		}

		isExpired := userSession.Expiry.Before(time.Now().Local())
		// send unauthorized user status in case session cookie has expired
		if isExpired {
			data.DeleteTracking(sessionToken)
			w.WriteHeader(http.StatusUnauthorized)
			fmt.Println("Session Expired for tasks")
			return
		}

		var tasks []data.Task
		// SQL query for getting 10 random questions from database
		rows, err := common.Database.Query("SELECT task_id, Question, Choice1, Choice2, Choice3, AnswerIndex FROM tasks ORDER BY RAND() LIMIT 10")
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			fmt.Println("Server database query error")
			return
		}
		defer rows.Close()

		// insert data into the Task structure
		for rows.Next() {
			var task data.Task
			var choice1, choice2, choice3 string
			if err := rows.Scan(&task.TaskID, &task.Question, &choice1, &choice2, &choice3, &task.AnswerIndex); err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}
			task.Choices = []string{choice1, choice2, choice3}
			tasks = append(tasks, task)
		}

		// check for errors in database
		if err := rows.Err(); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		// format the tasks structure to JSON and send to the frontend
		// SetEscapeHTML set to false, since the '&&' were being replaced with \u0026.
		// reference: https://stackoverflow.com/questions/28595664/how-to-stop-json-marshal-from-escaping-and
		encodeTasks := json.NewEncoder(w)
		encodeTasks.SetEscapeHTML(false)
		encodeTasks.Encode(tasks)
	}
}
