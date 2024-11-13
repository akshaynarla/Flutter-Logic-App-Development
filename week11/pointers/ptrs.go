package main

import "fmt"

type Position struct {
	X, Y int
}

func main() {
	i, j := 42, 2701

	p := &i         // point to i
	fmt.Println(*p) // read i through the pointer i.e, *&i which equals to i, 42
	*p = 21         // dereferencing. set i through the pointer. *&i=21 now. i.e., i=21
	fmt.Println(i)  // see the new value of i

	p = &j         // point to j
	*p = *p / 37   // divide j through the pointer
	fmt.Println(j) // see the new value of j

	n := Position{Y: 1} // implicit and explicit initialization
	fmt.Println(n)      // defaults to {0,0} init
	m := Position{3, 4}
	fmt.Println(m)
	o := &m        // referencing struct m at o
	o.X = 9        // accessing struct fields through pointers
	fmt.Println(m) // m has updated X value

}
