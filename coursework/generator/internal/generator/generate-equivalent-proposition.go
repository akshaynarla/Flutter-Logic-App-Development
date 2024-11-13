package generator

func generateEquivalentProposition(proposition string, eval []bool) string {
	// generate a new proposition
	newProposition := GenerateProposition()

	// if the new generated proposition is same as the previously generated proposition,
	// generate proposition again, until a different expression is generated
	for proposition == newProposition {
		newProposition = GenerateProposition()
	}

	newEval := generateTruthtable(newProposition)

	// check if the generated truth table results for the eval proposition
	// and the newEval proposition are the same, if not repeat the above process
	for !similarEval(eval, newEval) {
		newProposition = GenerateProposition()

		for proposition == newProposition {
			newProposition = GenerateProposition()
		}
		newEval = generateTruthtable(newProposition)

	}

	// return the equivalent proposition with same truth table output
	return newProposition
}

func similarEval(list1, list2 []bool) bool {
	// Then, compare each element in the 2 lists
	for i, value := range list1 {
		// value from the first list not same as second, return false => not equivalent
		if value != list2[i] {
			return false
		}
	}
	// return true => if the truth tables for the generated expressions are equivalent
	return true
}
