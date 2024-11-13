package main

// implement a square root function as per the exercise in go-tour
// https://go.dev/tour/flowcontrol/8
import (
	"fmt"
)

func Sqrt(x float64) float64 {
	z := 1.0
	for i := 0; i < 10; i++ {
		// Use of newton's method as suggested in hints of the exercise
		z -= (z*z - x) / (2 * z)
		fmt.Println(z)
	}
	return z
}

func main() {
	// the loops go file will run from here.
	fmt.Println(Sqrt(2))
}
