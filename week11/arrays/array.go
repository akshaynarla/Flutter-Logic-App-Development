package main

import "fmt"

func main() {
	var a [2]string // array declaration format with default init, which is empty array
	a[0] = "Hello"
	a[1] = "World"
	fmt.Println(a[0], a[1]) // access array elements
	fmt.Println(a)          // outputs entire array
	// you can also use a make function to create dynamically sized arrays. Allocates a zeroed array
	primes := []int{2, 3, 5, 7, 11, 13} // array declaration format with explicit init
	fmt.Println(primes)
	var s []int = primes[1:4] // array slicing, displays 1,2,3, s is an integer array with any number of elements
	fmt.Println(s)

	var t []int = primes[2:6]
	fmt.Println(t) // slice describes a section of the array

	// changing elements of a slice, modifies the corresponding element of array
	// as can be observed in the following console output
	t[2] = 99
	// t[2] = 99, changes the actual array element of primes and corresponding change also observed
	// in any other slices as well
	fmt.Println(s, t, primes)

	primes = primes[1:5] // primes is assigned here, therefore the primes array is now replaced with this slice
	// All following primes usage will be this new array
	fmt.Println("New primes values:", primes)
	// appending to an array or slice
	primes = append(primes, 9, 11)
	fmt.Println("Appended primes values:", primes)

}
