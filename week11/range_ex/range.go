package main

import "fmt"

var pow = []int{1, 2, 4, 8, 16, 32, 64, 128}

// keys of the map. Here 2 keys
type Vertex struct {
	Lat, Long float64
}

// declaring a map of strings
var m = map[string]Vertex{
	"Bell Labs": {
		40.68433, -74.39967,
	},
	"Akshay": {21, 30}}

func main() {
	// ranging gives the index and the copy of value --> 2 values returned
	// omit the variables, if you don't need them. Eg: for i := range pow and so on.
	for i, v := range pow {
		fmt.Printf("2**%d = %d\n", i, v)
	}
	// init map
	// m = make(map[string]Vertex)
	// m["Bell Labs"] = Vertex{
	//	40.68433, -74.39967,
	// }
	// map literals
	fmt.Println(m)
	// updating map element
	m["Akshay"] = Vertex{30, 21}
	fmt.Println("Bell labs: ", m["Bell Labs"])
	fmt.Println("Akshay is ", m["Akshay"])
	delete(m, "Bell Labs")
	fmt.Println("New map is:", m)
}
