package admin

import (
	"fmt"
	"net/http"
	"serverside/internal/data"
	"strconv"
)

// user-management modified from: https://github.com/zjhnb11/logic_quiz_App
// returns init message of server on get request
func AddTask(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case "POST":
		// Parse form data
		err := r.ParseForm()
		if err != nil {
			http.Error(w, "Unable to parse form", http.StatusBadRequest)
			return
		}

		// Get HTML data
		question := r.FormValue("question")
		choice1 := r.FormValue("choice1")
		choice2 := r.FormValue("choice2")
		choice3 := r.FormValue("choice3")
		answerIndex := r.FormValue("answerIndex")

		answerIdx, _ := strconv.Atoi(answerIndex)

		// insert new task onto the database
		taskID, err := data.InsertTask(question, choice1, choice2, choice3, answerIdx)
		if err != nil {
			http.Error(w, "Cannot insert task to database", http.StatusInternalServerError)
			return
		}

		fmt.Fprintf(w, "Task successfully added to database with ID %d", taskID)
	}
}
