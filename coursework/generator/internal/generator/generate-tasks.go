package generator

import (
	"fmt"
	"generator/internal/model"
)

// GenerateTasks generates propositional logic tasks and outputs it in the "Task" structure
func GenerateTasks(numTasks int) []model.Task {
	var tasks []model.Task

	for i := 0; i < numTasks; i++ {
		// Generate a random proposition
		fmt.Println("Generating task now:", i+1)
		proposition := GenerateProposition()

		// Generate choices for the proposition
		choices, answer_index := GenerateChoices(proposition)

		// Create a new task
		task := model.Task{
			TaskID:     i + 1,
			Question:   proposition,
			Choices:    choices,
			CorrectAns: answer_index,
		}

		// Append the task to the list of tasks
		tasks = append(tasks, task)
		// for debugging in CLI
		fmt.Println("Generated task id:", i+1)
		fmt.Println("Generated task:", task)
	}

	return tasks
}
