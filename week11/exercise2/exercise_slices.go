package main

import "golang.org/x/tour/pic"

func Pic(dx, dy int) [][]uint8 {
	// init empty pic, using make to create slice dy
	pic := make([][]uint8, dy)
	for i := range pic {
		// allocating each element within "pic"
		pic[i] = make([]uint8, dx)
		for j := range pic[i] {
			// image choice: x*y. runs well on the online tool. On local, rendering is not done.
			pic[i][j] = uint8(i * j)
		}
	}
	// return the pic i.e., dy
	return pic
}

func main() {
	pic.Show(Pic)
}
