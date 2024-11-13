package data

import (
	"fmt"
	"log"
	"serverside/internal/common"
)

// returns the record for the supplied username from the user_stats table
func UserStats(username string) (returnedUserStats []UserStatistic) {
	sqlQuery := "select * from user_stats where username=?"
	fmt.Println("UserStats for", username)
	stmt, err := common.Database.Prepare(sqlQuery)
	if err != nil {
		fmt.Println("Error preparing stats query:", err)
		return []UserStatistic{}
	}
	defer stmt.Close()

	res, err := stmt.Query(username)
	if err != nil {
		fmt.Println("Error executing stats query:", err)
		return []UserStatistic{}
	}

	// close sql query before the exit of the function
	defer func() {
		err := res.Close()
		if err != nil {
			fmt.Println("Error in closing stats query..", err)
		}
	}()

	var userStats []UserStatistic

	for res.Next() {
		var singleStat UserStatistic
		// https://stackoverflow.com/questions/56525471/how-to-use-rows-scan-of-gos-database-sql
		err := res.Scan(&singleStat.Username, &singleStat.Score, &singleStat.Mode, &singleStat.SessionCount)
		if err != nil {
			log.Fatal(err)
		}
		userStats = append(userStats, singleStat)
	}

	return userStats
}
