package main

import (
	"fmt"
	"io"
	"strings"
)

func main() {
	r := strings.NewReader("Hello, Akshay Narla!")
	// b has the corresponding ASCII values
	b := make([]byte, 8)
	for {
		// reads or outputs 8 bytes at a time, until EOF is reached
		// n = number of bytes read. This Read is the reader interface
		n, err := r.Read(b)
		fmt.Printf("n = %v err = %v b = %v\n", n, err, b)
		fmt.Printf("b[:n] = %q\n", b[:n])
		// Returns EOF if stream has ended
		if err == io.EOF {
			break
		}
	}
}
