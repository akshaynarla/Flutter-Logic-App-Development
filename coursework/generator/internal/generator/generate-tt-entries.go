package generator

import "math"

// generateTtEntries generates the truth table entries for the generated proposition
// i.e., for 4 variables different combinations of true-falses
func generateTtEntries(variables []string) []map[string]interface{} {
	// number of possible combinations based on the defined variables
	totalCombinations := int(math.Pow(2, float64(len(variables))))
	allCombinations := make([]map[string]interface{}, totalCombinations)

	// generate the combinations
	for i := 0; i < totalCombinations; i++ {
		combination := make(map[string]interface{})
		for j, variable := range variables {
			combination[variable] = (i>>j)&1 == 1
		}
		allCombinations[i] = combination
	}

	return allCombinations
}
