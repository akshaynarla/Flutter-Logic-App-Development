package main

import (
	"database/sql"
	"fmt"
	"net/http"
	"serverside/internal/admin"
	"serverside/internal/common"
	"serverside/internal/handlers"
	"serverside/internal/jsondata"
	"serverside/internal/usermgr"
	"time"
)

// reference: https://go.dev/doc/tutorial/database-access
func main() {
	// opens connection to the SQL Database
	// reference: https://www.geeksforgeeks.org/how-to-connect-to-mysql-server-using-vs-code-and-fix-errors/
	common.Database, common.DbError = sql.Open("mysql", "sqluser:quizzy@tcp(127.0.0.1:3306)/quizzy_server?parseTime=true")
	if common.DbError != nil {
		fmt.Println(common.DbError)
	}
	fmt.Println("Database successfully connected at:", time.Now().Local())

	// close connection to database after server stops.
	// Essentially runs after ListenAndServe ends
	// Reference: https://www.honeybadger.io/blog/go-exception-handling/
	defer func() {
		err := common.Database.Close()
		if err != nil {
			fmt.Println("Error in closing database connection...", err)
		}
	}()

	// flood database with quiz questions from generated json file
	common.JsonError = jsondata.JsonFlood("../tasks_backend.json")
	if common.JsonError != nil {
		fmt.Println(common.JsonError)
	}

	// defining mux routes based on http package and the
	router := http.NewServeMux()

	// path followed by the handler function when the http request has the parsed path format
	// user management functionalities --> login, register and reset passcode
	router.HandleFunc("/login", usermgr.LoginHandler)
	router.HandleFunc("/register", usermgr.RegisterHandler)
	router.HandleFunc("/resetpasscode", usermgr.ResetpcHandler)

	// other server functionalities
	router.HandleFunc("/online", handlers.OnlineHandler)
	router.HandleFunc("/tasks", handlers.TasksHandler)
	router.HandleFunc("/stats", handlers.StatsHandler)
	router.HandleFunc("/admin", handlers.AdminHandler)
	router.HandleFunc("/signout", handlers.SignoutHandler)

	// admin functionalities
	router.HandleFunc("/admin/addtask", admin.AddTask)
	router.HandleFunc("/admin/removetask", admin.RemoveTask)
	router.HandleFunc("/admin/resetuserpc", admin.ResetUserPc)
	router.HandleFunc("/admin/removeuser", admin.RemoveUser)

	fmt.Printf("Server is running on port 8080\n")
	// Listen to the server "router" and serve clients via port 8080
	http.ListenAndServe(":8080", router)
}
