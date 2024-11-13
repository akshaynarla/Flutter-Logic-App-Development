package handlers

import (
	"html/template"
	"net/http"
	"serverside/internal/admin"
	"serverside/internal/common"
	"serverside/internal/data"
)

// returns html page of the admin based on the template file.
// top performers of the app and anonymously tracked session detail is also now available to the admin here.
func AdminHandler(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case "GET":
		sessions, err := data.FetchSessionData(common.Database)
		if err != nil {
			http.Error(w, "Failed to fetch sessions", http.StatusInternalServerError)
			return
		}

		topUsers, err := admin.GetTopUsers(common.Database)
		if err != nil {
			http.Error(w, "Failed to fetch top users", http.StatusInternalServerError)
			return
		}
		// data structure to be returned to the HTML page
		// in case of improvements, new data structures can be added and handled accordingly
		data := struct {
			Sessions []data.Session
			TopUsers []data.UserAccuracy
		}{
			Sessions: sessions,
			TopUsers: topUsers,
		}

		// Load HTML template. Template modified from: https://github.com/zjhnb11/logic_quiz_App
		tmpl, err := template.ParseFiles("../admin_page.html")
		if err != nil {
			http.Error(w, "Could not load admin page", http.StatusInternalServerError)
			return
		}

		err = tmpl.Execute(w, data)
		if err != nil {
			http.Error(w, "Failed to execute template", http.StatusInternalServerError)
			return
		}

	}
}
