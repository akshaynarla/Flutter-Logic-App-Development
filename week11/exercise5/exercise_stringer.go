package main

import (
	"fmt"
	"strconv"
	"strings"
)

type IPAddr [4]byte

// from the example in go tour
func (ip IPAddr) String() string {
	s := make([]string, len(ip))
	// iterate over the parsed map elements and return the ip
	// type cast to take proper integers
	for i, val := range ip {
		s[i] = strconv.Itoa(int(val))
		// fmt.Println(s[i])
	}
	return strings.Join(s, ".")
}

func main() {
	hosts := map[string]IPAddr{
		"loopback":  {127, 0, 0, 1},
		"googleDNS": {8, 8, 8, 8},
	}
	// iterate over the hosts to get the Ip address format
	for name, ip := range hosts {
		// ip function called here. First ip gets executed. Then, printed here.
		fmt.Printf("%v: %v\n", name, ip)
	}
}
