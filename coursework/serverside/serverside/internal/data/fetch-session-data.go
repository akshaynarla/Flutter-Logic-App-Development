package data

import (
	"database/sql"
)

// fetch tracking of sessions data for admin page
// details of the session token and username is provided to HTML
// Scan --> returns all data in the row based on the query and provides it to the data structure session
func FetchSessionData(db *sql.DB) ([]Session, error) {
	var sessions []Session

	rows, err := db.Query("SELECT username, token, expiresAt FROM sessions")
	if err != nil {
		return []Session{}, err
	}
	defer rows.Close()

	for rows.Next() {
		var s Session
		if err := rows.Scan(&s.Username, &s.Token, &s.Expiry); err != nil {
			return []Session{}, err
		}
		sessions = append(sessions, s)
	}

	if err = rows.Err(); err != nil {
		return []Session{}, err
	}

	return sessions, nil
}
