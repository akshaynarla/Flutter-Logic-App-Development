package jsondata

import (
	"encoding/json"
	"fmt"
	"io"
	"os"
	"serverside/internal/data"
)

// function to populate the sql database with the server tasks. Here, generated tasks are added into the database.
// In case, new data is to be added --> generate a new JSON file or use the Admin HTML interface
func JsonFlood(filePath string) error {
	var Tasks []data.Task
	// read tasks from the json file -- depending on the file name
	// change if you want to use a different json file --> "../../server_tasks.json" or some other name
	jsonTasks, err := os.Open(filePath)
	if err != nil {
		fmt.Println(err)
	}
	fmt.Println("tasks json file is loaded..")
	defer jsonTasks.Close()

	// read json as a byte array.
	byteValue, _ := io.ReadAll(jsonTasks)
	json.Unmarshal([]byte(byteValue), &Tasks)

	// loop over all the unmarshalled tasks from JSON file and add to the SQL database
	for _, task := range Tasks {
		taskID, err := data.InsertTaskInit(task.TaskID, task.Question, task.Choices[0], task.Choices[1], task.Choices[2], task.AnswerIndex)
		if err != nil {
			return err
		}
		fmt.Println("Task successfully added to database with:", taskID)
	}

	return nil
}
