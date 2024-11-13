package data

import "time"

// this file defines the data structure for correctly reading or writing json data
// allows for easy data management

// data structure for sending Tasks --> similar to the structure in frontend
type Task struct {
	TaskID      int      `json:"task_id"`
	Question    string   `json:"question"`
	Choices     []string `json:"choices"`
	AnswerIndex int      `json:"correctAns"`
}

// User structure is used for logging in and communicating user data in json
type User struct {
	Username string
	Passcode string
}

// Data structure for communication of user_stats data via JSON
type UserStatistic struct {
	Username     string `json:"username"`
	Score        int    `json:"score"`
	Mode         string `json:"mode"`
	SessionCount int    `json:"sessions"`
}

// Redundant and same user data structure "User" could be used for following 3 structures
// Easier for maintainability --> problem when the structure is bigger and takes lot of memory
type UserCredentials struct {
	Username string `json:"username"`
	Passcode string `json:"passcode"`
}

type UserRegistration struct {
	Username string `json:"username"`
	Passcode string `json:"passcode"`
}

type ResetUserPasscode struct {
	Username    string `json:"username"`
	NewPasscode string `json:"passcode"`
}

// session is used for anonymous tracking of user logins
type Session struct {
	Username string
	Token    string
	Expiry   time.Time
}

// Composite data structure: https://www.geeksforgeeks.org/nested-structure-in-golang/
// this structure allows to send data to HTML page --> without having to manipulate sql table directly
type UserAccuracy struct {
	UserStatistic
	Accuracy float64
}
