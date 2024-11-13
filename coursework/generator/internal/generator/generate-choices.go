package generator

import "math/rand"

// https://go.dev/blog/slices --> for list manipulation
// GenerateChoices generates choices for the generated proposition
// returns the equivalent proposition and the corresponding index
func GenerateChoices(proposition string) ([]string, int) {
	var answerIndex int
	var correctChoice = make([]string, 0)
	var falseChoices = make([]string, 0)

	// truth-table evaluation for the generated proposition
	eval := generateTruthtable(proposition)

	// equivalent proposition generation with the same eval value as above
	equivalentProposition := generateEquivalentProposition(proposition, eval)

	// https://www.calhoun.io/how-to-shuffle-arrays-and-slices-in-go/
	// append the generated equivalent proposition, since it is the correct choice
	correctChoice = append(correctChoice, equivalentProposition)
	falseChoices = generateFalseChoice(proposition, eval)

	// unpack the falseChoices and add it to the choices list
	// reference: https://yourbasic.org/golang/append-explained/
	choices := append(correctChoice, falseChoices...)

	// shuffle the choices reference for shuffle: https://golang.cafe/blog/how-to-shuffle-a-slice-in-go.html
	rand.Shuffle(len(choices), func(i, j int) { choices[i], choices[j] = choices[j], choices[i] })
	// get the index of equivalent proposition from the choices --> which is the answerIndex
	for i, v := range choices {
		if v == equivalentProposition {
			answerIndex = i
			break
		}
	}
	// fmt.Println("Generating choices....")
	return choices, answerIndex
}

// generateFalseChoice generates false options for the generated proposition
func generateFalseChoice(proposition string, eval []bool) []string {
	falseOpts := make([]string, 0)

	// generate 2 false choices
	for i := 0; i < 2; i++ {
		altProposition := GenerateProposition()
		altEval := generateTruthtable(altProposition)

		// incase of same truth table evaluation, generate new propositions which are not equal
		for similarEval(eval, altEval) {
			altProposition = GenerateProposition()
			altEval = generateTruthtable(altProposition)
		}

		// append the generated false propositions and provide it as false choices
		falseOpts = append(falseOpts, altProposition)
	}

	return falseOpts
}
