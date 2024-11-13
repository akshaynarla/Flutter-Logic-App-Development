package main

import (
	"fmt"
	"math"
)

type MyFloat float64

// method is just a function with reciever argument.
// there are no classes in go.
// Vertex is a structure
type Vertex struct {
	X, Y float64
}

// Abs is a method. Abs has a receiver argument v:Vertex structure.
// Abs receives the v values.
func Abs(v Vertex) float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}

// The methods can use non-struct values as well.
func Abso(f MyFloat) float64 {
	if f < 0 {
		return float64(-f)
	}
	return float64(f)
}

// this makes more or less similar like classes. It will act as the class method.
// accessible in the main as v.Scale --> makes Scale(uses the variables of v) a function of v.
// Here a pointer to the struct Vertex is given and then the function can change the vertex value.
// else it won't change the vertex value and it remains the same as before. (remove pointer and verify)
// avoids copying the value every time this is called.
func (v *Vertex) Scale(f float64) {
	v.X = v.X * f
	v.Y = v.Y * f
}

func ScaleFunc(v *Vertex, f float64) {
	v.X = v.X * f
	v.Y = v.Y * f
}

func main() {
	v := Vertex{3, 4}
	fmt.Println(Abs(v))
	f := MyFloat(-math.Sqrt2)
	// fmt.Println(f.Abso())
	fmt.Println(Abso(f))
	// scales the vertex values now
	v.Scale(10)
	fmt.Println(Abs(v))

	p := &Vertex{4, 3}
	p.Scale(3)
	// pointer parsed here
	ScaleFunc(p, 8)
	// v from previous. And p point is scaled differently here.
	fmt.Println(v, p)
}
