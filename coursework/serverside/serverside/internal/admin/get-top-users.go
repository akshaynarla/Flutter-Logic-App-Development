package admin

import (
	"database/sql"
	"serverside/internal/data"
	"sort"
)

// method to obtain the top 3 users based on their accuracies or score per session
// data from user_stats table is fetched and sorted. Top 3 user accuracies is returned to HTML.
func GetTopUsers(db *sql.DB) ([]data.UserAccuracy, error) {
	rows, err := db.Query("SELECT username, score, mode, sessions FROM user_stats WHERE sessions > 0")
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var users []data.UserAccuracy

	for rows.Next() {
		var SqlStat data.UserStatistic
		if err := rows.Scan(&SqlStat.Username, &SqlStat.Score, &SqlStat.Mode, &SqlStat.SessionCount); err != nil {
			return nil, err
		}
		accuracy := float64(SqlStat.Score) / float64(SqlStat.SessionCount)
		users = append(users, data.UserAccuracy{UserStatistic: SqlStat, Accuracy: accuracy})
	}

	if err = rows.Err(); err != nil {
		return nil, err
	}

	// sort users by calculated accuracy : https://pkg.go.dev/sort
	sort.Slice(users, func(i, j int) bool {
		return users[i].Accuracy > users[j].Accuracy
	})

	// limit to top 3 users
	if len(users) > 3 {
		users = users[:3]
	}

	return users, nil
}
