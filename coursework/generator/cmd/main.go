package main

import (
	"fmt"
	"generator/internal/generator"
	"generator/internal/model"
)

func main() {
	const numTasks = 200

	// GenerateTasks function generates the propositional logic tasks
	questions := generator.GenerateTasks(numTasks)

	// write the generated questions and list to json
	err := model.WriteToJson(questions, "../generated_backend.json")

	if err != nil {
		fmt.Println(err)
	}
	// success message in case of json file generation
	fmt.Println("Quiz questions now available as generated_backend.json")
}
