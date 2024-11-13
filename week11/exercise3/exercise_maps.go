package main

// referred from: https://github.com/benoitvallon/a-tour-of-go/blob/master/exercise-maps.go

import (
	"strings"

	"golang.org/x/tour/wc"
)

func WordCount(s string) map[string]int {
	// m is the map of strings
	m := make(map[string]int)
	// Fields splits the parsed string based on whitespaces
	// words is an array of strings now. Iterate over it to obtain a map for count of words
	words := strings.Fields(s)
	for _, value := range words {
		// v helps in keeping count
		// m of the parsed word. If the value already exists, increment count of the value.
		v, ok := m[value]
		if ok {
			m[value] = v + 1
		} else {
			m[value] = 1
		}
	}
	return m
}

func main() {
	wc.Test(WordCount)
}
