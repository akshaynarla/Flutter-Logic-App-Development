package dice

// Class functionality copied from week3
// The initial test was done with the variables same as week3.
// In Go, to expose the variable to public, the variable has to be WithACaps.
// All variables with smallVars are private to the structure and cannot be accessed
// without getter methods.

import (
	"math/rand"
)

// Dice struct for rolling 2 dice
type Dice struct {
	minDie, maxDie int
	EqualDistr     bool
	Die            []int
	NumberOfThrows int
	SumStatistics  []int
	DieStatistics  [][]int
}

// method for creating a dice instance
// initialized with the passed value and the initializations done here.
func NewDice(numberOfThrows int, equalDistr bool) *Dice {
	// minDie and maxDie has to be changed here
	// Tested with other min and max values as well
	minDie := 1
	maxDie := 6
	dieStatistics := make([][]int, maxDie)
	for i := range dieStatistics {
		dieStatistics[i] = make([]int, maxDie)
	}

	return &Dice{
		minDie:         minDie,
		maxDie:         maxDie,
		EqualDistr:     equalDistr,
		Die:            make([]int, 2),
		NumberOfThrows: numberOfThrows,
		SumStatistics:  make([]int, (2*maxDie)-1),
		DieStatistics:  dieStatistics,
	}
}

// method equivalent to throw dice in week3
// nothing is changed and only the syntax has been changed
func (d *Dice) ThrowDice() {
	if d.EqualDistr {
		possibleSums := make([]int, (2*d.maxDie)-1)
		for i := 0; i < (2*d.maxDie)-1; i++ {
			possibleSums[i] = i + 2
		}
		selectedSum := possibleSums[rand.Intn((2*d.maxDie)-1)]

		// List of dice combinations for a given sum value
		combiSum := [][]int{}
		for i := 1; i <= d.maxDie; i++ {
			for j := 1; j <= d.maxDie; j++ {
				if i+j == selectedSum {
					// add all possible combinations for a given sum onto a temporary list
					combiSum = append(combiSum, []int{i, j})
				}
			}
		}
		d.Die = combiSum[rand.Intn(len(combiSum))]
	} else {

		// generate random dice output on each dice
		d.Die[0] = rand.Intn(d.maxDie) + 1
		d.Die[1] = rand.Intn(d.maxDie) + 1
	}

	// take the sum of the die output
	sum := d.Die[0] + d.Die[1]
	d.SumStatistics[sum-2] += 1
	d.DieStatistics[d.Die[0]-1][d.Die[1]-1]++

}

func (d *Dice) ResetStatistics() {
	// replace list elements with 0's
	d.SumStatistics = make([]int, (2*d.maxDie)-1)
	d.DieStatistics = make([][]int, d.maxDie)
	for i := range d.DieStatistics {
		d.DieStatistics[i] = make([]int, d.maxDie)
	}
}

// Setter method for equalDistr.
// Since equalDistr was set through the func NewDice, we will retain equalDist as it is
// set it using a setter method, whenever necessary
func (d *Dice) SetEqualDistribution(equalDistr bool) {
	d.EqualDistr = equalDistr
}
