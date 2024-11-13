package main

// import can be separate, like python style
// but if you created a group, then
import (
	"fmt"
	"math"
	"math/rand"
)

// global variable with default initialization
var b bool

const g = 9.8

// to reduce coding, if same parameter data type is used: (a int, b int) --> (a,b int)
func mul(a, b int) int {
	return a * b
}

// there can be something known as "naked return", where you define the named return parameter during
// declaration and just use return then.
func swap(a, b string) (string, string) {
	return b, a
}

func main() {
	// declaration style in go. Same for local and global declarations
	// var i string = "Akshay"
	// var j string = "Narla" can be rewritten as
	// var i, j string = "Akshay", "Narla" which can also be rewritten as
	i, j := "Akshay", "Narla" // known as short variable declarations, valid only within a function

	// the function name following the library is always starting with capital letter
	// i.e., rand.intn is undefined and works with rand.Intn. Name is exported only if it begins with a capital letter
	fmt.Println("My favorite number is", rand.Intn(10))

	// when you have to format a number, use printf instead of println (just prints a line, no formatting)
	fmt.Printf("Random math function output is %g.\n", math.Sqrt(101))
	// explicit type conversion
	fmt.Printf("Equivalent type-conversion output is %d.\n", int16(math.Sqrt(101)))
	fmt.Printf("The product of 8 and 7 is: %d.\n", mul(8, 7))

	x, y := swap(i, j)
	fmt.Println("Initial string is:", i, j)
	fmt.Println("Swapped string is:", x, y)
	fmt.Println("Default boolean value is:", b)

	// String concatenation, like python here
	fmt.Println("The gravitational acceleration of earth is:", g, "m/s^2")
}
