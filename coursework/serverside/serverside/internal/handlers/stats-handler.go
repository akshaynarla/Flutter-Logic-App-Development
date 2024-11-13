package handlers

import (
	"encoding/json"
	"fmt"
	"net/http"
	"serverside/internal/common"
	"serverside/internal/data"
	"time"
)

// POST case similar to: https://github.com/zjhnb11/logic_quiz_App
// returns stats of the user on post request
func StatsHandler(w http.ResponseWriter, r *http.Request) {
	c, err := r.Cookie("session_token")
	if err != nil {
		if err == http.ErrNoCookie {
			// if cookie is not set return an unauthorized status
			w.WriteHeader(http.StatusUnauthorized)
			fmt.Println("Request has no cookie")
			return
		}
		w.WriteHeader(http.StatusBadRequest)
		return
	}
	sessionToken := c.Value

	userSession, exists := data.CheckSessionValidity(sessionToken)
	if !exists {
		// if the session token is not existing in session table, return an unauthorized status
		w.WriteHeader(http.StatusUnauthorized)
		fmt.Println("Session does not exist for user")
		return
	}

	IsExpired := userSession.Expiry.Before(time.Now())

	// if user session has expired, delete session data from database and exit the submit function
	if IsExpired {
		// delete session and login again
		data.DeleteTracking(sessionToken)
		w.WriteHeader(http.StatusUnauthorized)
		fmt.Println("Session Expired for stats")
		return
	}

	switch r.Method {
	case "GET":
		{
			fmt.Println("FetchStats hits in server")
			// If the session is valid, return the user_stats back to frontend in json format
			userStats := data.UserStats(userSession.Username)
			fmt.Println("Sent statistics:", userStats)
			w.Header().Set("Content-Type", "application/json")
			jsonData, _ := json.Marshal(userStats)
			w.WriteHeader(http.StatusOK)
			w.Write(jsonData)
			fmt.Println("Sent statistics:", userStats)
		}

	case "POST":
		var stats []data.UserStatistic
		if err := json.NewDecoder(r.Body).Decode(&stats); err != nil {
			http.Error(w, err.Error(), http.StatusBadRequest)
			return
		}
		fmt.Println("Received statistics:", stats)

		// Store scores into user table
		for _, stat := range stats {
			_, err := common.Database.Exec("UPDATE user_stats SET score = ?, sessions = ? WHERE username = ? AND mode = ?",
				stat.Score, stat.SessionCount, stat.Username, stat.Mode)

			if err != nil {
				http.Error(w, "stats could not be uploaded to database", http.StatusInternalServerError)
				return
			}
		}

		w.WriteHeader(http.StatusOK)
	}
}
