package main

import (
	"fmt"
)

type ErrorMsg float64

// sprintf for formatting and a simple error message based on the if condition in sqrt
func (e ErrorMsg) Error() string {
	return fmt.Sprintf("Not possible to take the sqrt of negative number:%v", float64(e))
}

// sqrt from exercise 1
func Sqrt(x float64) (float64, error) {
	if x < 0 {
		return 0, ErrorMsg(x)
	}
	z := 1.0
	for i := 0; i < 10; i++ {
		// Use of newton's method as suggested in hints of the exercise
		z -= (z*z - x) / (2 * z)
		fmt.Println(z)
	}
	return z, nil
}

func main() {
	fmt.Println(Sqrt(2))
	fmt.Println(Sqrt(-2))
}
