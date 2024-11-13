package model

// Task represents a single quiz question and helps output generated tasks in correct format.
// This is in the same format as the frontend questions.
type Task struct {
	TaskID     int      `json:"task_id"`
	Question   string   `json:"question"`
	Choices    []string `json:"choices"`
	CorrectAns int      `json:"correctAns"`
}
