package generator

import "github.com/maja42/goval"

// GenerateChoices generates choices for the generated proposition
// to-do: generate equivalent expression for the given proposition --> use govaluate maybe
func generateTruthtable(proposition string) []bool {
	varNames := []string{"P", "Q", "R", "S"}[:4]

	allCombinations := generateTtEntries(varNames)
	// truthTableEval holds the logic evaluation result of the generated proposition (based on the above truth table)
	var truthTableEval []bool
	// goval is a library that helps evaluate the generated proposition
	eval := goval.NewEvaluator()

	for _, combination := range allCombinations {
		result, _ := eval.Evaluate(proposition, combination, nil)
		if resultBool, ok := result.(bool); ok {
			truthTableEval = append(truthTableEval, resultBool)
		}
	}

	return truthTableEval
}
