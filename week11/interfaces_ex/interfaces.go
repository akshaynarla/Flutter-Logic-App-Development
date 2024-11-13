package main

import (
	"fmt"
	"math"
)

// new interface type. implements an interface by implementing methods.
// interfaces are method signatures. i.e., Use the interface to call the method.
type Abser interface {
	Abs() float64
}

type I interface {
	M()
}

func main() {
	var a Abser
	fmt.Println(a)
	f := MyFloat(-math.Sqrt2)
	v := Vertex{3, 4}
	// a can now be used with anything that implements the Abs()
	a = f // a MyFloat implements Abser
	fmt.Println(a)
	a = &v // a *Vertex implements Abser
	fmt.Println(a)

	fmt.Println(a.Abs())
	// implicit interface for T
	var i I = T{"hello"}
	i.M()
}

type MyFloat float64

func (f MyFloat) Abs() float64 {
	if f < 0 {
		return float64(-f)
	}
	return float64(f)
}

type Vertex struct {
	X, Y float64
}

func (v *Vertex) Abs() float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}

type T struct {
	S string
}

// This method means type T implements the interface I,
// but we don't need to explicitly declare that it does so.
func (t T) M() {
	fmt.Println(t.S)
}
