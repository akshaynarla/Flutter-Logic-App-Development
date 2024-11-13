package main

import (
	"fmt"
	"time"
)

// concurrency examples

func fibonacci(n int, c chan int) {
	x, y := 0, 1
	for i := 0; i < n; i++ {
		// loading to buffer
		fmt.Println("Fibonacci routine ongoing...")
		c <- x
		time.Sleep(100 * time.Millisecond)
		x, y = y, x+y
	}
	// close the channel when loop breaks
	fmt.Println("Closing the channel now...")
	close(c)
}

func main() {
	c := make(chan int, 10)
	go fibonacci(cap(c), c)
	// receive value from channel continuously until closed
	// as soon as value loaded onto channel in the func fibonacci,
	// it is printed here
	for i := range c {
		fmt.Println("Printing now:")
		fmt.Println(i)
	}

	tick := time.Tick(100 * time.Millisecond)
	boom := time.After(500 * time.Millisecond)
	for {
		// use of select keyword lets goroutine wait on multiple comm. operations
		// here waiting on tick, boom and a default case
		// select blocks execution until one of the case is executed
		select {
		case <-tick:
			fmt.Println("tick.")
		case <-boom:
			fmt.Println("BOOM!")
			return
		default:
			fmt.Println("    .")
			time.Sleep(50 * time.Millisecond)
		}
	}
}
