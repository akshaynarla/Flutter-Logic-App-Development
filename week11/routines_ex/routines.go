package main

import (
	"fmt"
	"time"
)

func say(s string) {
	for i := 0; i < 5; i++ {
		// delay
		time.Sleep(100 * time.Millisecond)
		// print the routine
		fmt.Println(s)
	}
}

func sum(s []int, c chan int) {
	sum := 0
	for _, v := range s {
		sum += v
	}
	// channels: sum is sent to c channel here
	c <- sum // send sum to c
}

func main() {
	// both routines run concurrently
	// go say creates a new goroutine. 2nd routine
	go say("world")
	// this in the main goroutine
	say("hello")
	// only when the above routines are completed, the program moves to next step
	s := []int{7, 2, 8, -9, 4, 0}
	// channel creation
	c := make(chan int)
	// sends and recieves int character. Sync without explicit locks
	go sum(s[:len(s)/2], c)
	go sum(s[len(s)/2:], c)
	x, y := <-c, <-c // receive from c
	fmt.Println(x, y, x+y)

	// buffered channel usage
	ch := make(chan int, 2)
	ch <- 1
	ch <- 2
	// if for example, you give ch <- 3, i.e., overfilling the buffer. Deadlock occurs in routine
	fmt.Println(<-ch)
	fmt.Println(<-ch)
}
