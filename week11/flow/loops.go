package main

import (
	"fmt"
	"math"
	"time"
)

func pow(x, n, lim float64) float64 {
	// first does v assignement and then returns v only if less than the limit.
	// combines if-else within if as follows.
	if v := math.Pow(x, n); v < lim {
		// v is valid only within the if scope
		return v
	}
	// if v used here, it will be undefined
	return lim
}

func main() {
	// defer functions with LIFO
	defer fmt.Println("Defer test 2")

	// simple for loop: no need of brackets in for, unlike in dart.
	// init and post statements are optional: i := 0, i++.
	sum := 0
	for i := 0; i < 10; i++ {
		sum += i
	}
	fmt.Println("Sum of first 10 integers is:", sum)

	// While is also for itself here. Infinite loop using for{}.
	for sum < 10 {
		sum += sum
	}
	fmt.Println("Sum of first 10 integers using while:", sum)

	fmt.Printf("3 squared is: %g\n", pow(3, 2, 10))

	// switch case do not allow conditions within switch. So do this without any variable
	x := pow(8, 2, 50)
	// defaults to switch true --> used to replace long if-elses
	switch {
	case (x > 50):
		fmt.Println("Output is greater than 50")
	case x == 50:
		fmt.Println("Output is equal to 50")
	default:
		fmt.Println("Default output")
	}

	defer fmt.Println("Defer test") // output generated after switch statements is completed.
	today := time.Now().Weekday()
	switch time.Saturday {
	case today + 0:
		fmt.Println("Today.")
	case today + 1:
		fmt.Println("Tomorrow.")
	case today + 2:
		fmt.Println("In two days.")
	default:
		fmt.Println("Too far away.")
	}
}
