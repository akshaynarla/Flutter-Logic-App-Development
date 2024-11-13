package data

import (
	"fmt"
	"serverside/internal/common"
)

// Insert data : Reference: https://github.com/zjhnb11/logic_quiz_App
func InsertTask(question, choice1, choice2, choice3 string, answerIndex int) (int64, error) {
	sqlStr := `insert into tasks(Question, Choice1, Choice2, Choice3, AnswerIndex) values (?, ?, ?, ?, ?)`
	ret, err := common.Database.Exec(sqlStr, question, choice1, choice2, choice3, answerIndex)
	if err != nil {
		return 0, fmt.Errorf("task insert failed, err:%v", err)
	}

	// id of the last added task
	ret_id, err := ret.LastInsertId()
	if err != nil {
		return 0, fmt.Errorf("insert ID failed, err:%v", err)
	}

	return ret_id, nil
}

// initial insert to database: here in case the database already has certain task_id, it will be replaced if data is different
// in case same data exists --> it will be ignored i.e., not replaced
func InsertTaskInit(taskid int, question, choice1, choice2, choice3 string, answerIndex int) (int64, error) {
	// insert new row of data only if unique task_id, else ignore --> makes task_id unique during initial insertion of quiz
	// Reference: https://www.tutorialspoint.com/mysql/mysql-handling-duplicates.htm
	sqlStr := `insert ignore into tasks(task_id, Question, Choice1, Choice2, Choice3, AnswerIndex) values (?, ?, ?, ?, ?, ?)`
	ret, err := common.Database.Exec(sqlStr, taskid, question, choice1, choice2, choice3, answerIndex)
	if err != nil {
		return 0, fmt.Errorf("task insert failed, err:%v", err)
	}

	// id of the last added task
	ret_id, err := ret.LastInsertId()
	if err != nil {
		return 0, fmt.Errorf("insert ID failed, err:%v", err)
	}

	return ret_id, nil
}
