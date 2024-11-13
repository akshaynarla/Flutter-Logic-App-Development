package main

import "fmt"

// functions are also values which can be parsed directly.
// function closure:
// fibonacci is a function that returns
// a function that returns an int.
func fibonacci() func() int {
	previous := 0
	history := 0
	// returns the function that will return an integer
	return func() int {
		num := history + previous
		if history == 0 {
			// next value to 1
			previous = 1
		}
		history = previous
		previous = num
		return num
	}
}

func main() {
	f := fibonacci()
	for i := 0; i < 10; i++ {
		fmt.Println(f())
	}
}
