package main

import (
	"fmt"
	"go_dice/dice"
	"os"
	"strconv"
)

func main() {

	// Check if a command-line argument is provided
	if len(os.Args) < 2 {
		fmt.Println("Usage: go run main.go <number_of_throws>")
		return
	}

	// Parsing the command-line argument as an integer using string to int converter
	// returns back error if parsed value cannot be converted to an integer
	numThrows, err := strconv.Atoi(os.Args[1])
	if err != nil {
		fmt.Println("Error: Please provide a valid integer for the number of throws.")
		return
	}

	// Creating a Dice instance
	diceInstance := dice.NewDice(numThrows, false)

	// First case: throwing dice 'numThrows' times and printing sum statistics
	for i := 0; i < diceInstance.NumberOfThrows; i++ {
		diceInstance.ThrowDice()
		// for debugging: fmt.Printf("Throw value: %v\n", diceInstance.Die)
	}

	// Displaying the results
	fmt.Printf("Sum Statistics in normal case: %v\n", diceInstance.SumStatistics)
	fmt.Printf("Die Statistics in normal case: %v\n", diceInstance.DieStatistics)

	// Resetting statistics
	diceInstance.ResetStatistics()
	fmt.Printf("Sum statistics is reset: %v\n", diceInstance.SumStatistics)
	fmt.Printf("Die Statistics is reset: %v\n", diceInstance.DieStatistics)

	// Second case: after reset of statistics
	diceInstance.SetEqualDistribution(true)
	for i := 0; i < diceInstance.NumberOfThrows; i++ {
		diceInstance.ThrowDice()
		// for debugging: fmt.Printf("Throw value: %v\n", diceInstance.Die)
	}

	// Displaying the results for the second case
	fmt.Printf("Sum Statistics in equal distribution case: %v\n", diceInstance.SumStatistics)
	fmt.Printf("Die Statistics in equal distribution case: %v\n", diceInstance.DieStatistics)
}
