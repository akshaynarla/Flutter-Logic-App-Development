package main

import (
	"fmt"
	"strings"
)

func main() {
	// Create a tic-tac-toe board. 2D explicit initialized array
	board := [][]string{
		{"_", "_", "_"},
		{"_", "_", "_"},
		{"_", "_", "_"},
	}

	// The players take turns.
	board[0][0] = "X"
	board[2][2] = "O"
	board[1][2] = "X"
	board[1][0] = "O"
	board[0][2] = "X"

	// length of board is 3 here, from inspection. string.Join allows joining the string elements
	// separated with space
	for i := 0; i < len(board); i++ {
		fmt.Printf("%s\n", strings.Join(board[i], " "))
	}
}
