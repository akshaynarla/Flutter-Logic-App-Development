package common

import (
	"database/sql"

	_ "github.com/go-sql-driver/mysql"
)

// package used to provide global variables
// here database is declared in addition to 2 other errors to be handled in the main.go file
var Database *sql.DB
var DbError error
var JsonError error
