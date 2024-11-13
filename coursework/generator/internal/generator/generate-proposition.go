package generator

import (
	"fmt"
	"math/rand"
)

// reference: mostly from examples in https://gobyexample.com/
// a map of generated propositions for verifying if a proposition is already generated
var generatedPropositions = make(map[string]bool)

var variables []string = []string{"P", "Q", "R", "S", "!P", "!Q", "!R", "!S"}
var operators []string = []string{"&&", "||"}

// GenerateProposition generates a random proposition for the quiz
// a rather naive approach is followed since all possible combination and operators are generated and one is selected from
func GenerateProposition() string {
	propositionLength := rand.Intn(2) + 1

	// generates initial proposition by looping over the variables list and producing a
	// logical expression with 2 variables combined with a random operator (not so random here, since only 2 operators are used)
	var proposition []string = make([]string, 0)
	for _, variable1 := range variables {
		for _, variable2 := range variables {
			if variable1 != variable2 {
				// generate proposition from the variables defined --> just by random combination
				var expr string = fmt.Sprintf("(%s %s %s)", variable1, operators[rand.Intn(len(operators))], variable2)
				// negate the expression randomly to increase complexity
				if rand.Float32() <= 0.5 {
					expr = "!" + expr
				}
				proposition = append(proposition, expr)
			}
		}
	}
	// fmt.Println("Initial proposition:", proposition)

	// Iteratively build more complex expressions based on randomly generated proposition complexity
	// here it refers to the following kind of example: generates (expr1 && expr2 || expr3) if proposition length is 3
	// here it is limited to only 2 and hence 4 variables would be possible in a question.
	for i := 1; i < propositionLength; i++ {
		var complexExpr []string = make([]string, 0)
		for j := 0; j < len(proposition); j++ {
			// pick a random proposition from the list and combine it with a random operator
			var expr1 string = proposition[rand.Intn(len(proposition))]
			var expr2 string = proposition[rand.Intn(len(proposition))]
			for expr1 == expr2 {
				expr2 = proposition[rand.Intn(len(proposition))]
			}
			var operator string = operators[rand.Intn(len(operators))]
			var expr string = fmt.Sprintf("(%s %s %s)", expr1, operator, expr2)
			if rand.Float32() <= 0.5 {
				expr = "!" + expr
			}
			complexExpr = append(complexExpr, expr)
		}
		proposition = complexExpr
	}

	// Verifying if the generated expression is unique by verifying the list of already generated proposition
	// and randomly selecting one proposition
	// here, maxAttempts is set to avoid infinite loop, in case no unique expression available
	var genProposition string
	maxAttempts := 100
	attempt := 0

	for {
		genProposition = proposition[rand.Intn(len(proposition))]
		if !generatedPropositions[genProposition] {
			// if unique proposition found, break out of the loop
			break
		}
		attempt++
		if attempt >= maxAttempts {
			// fmt.Println("Max attempts reached, unable to generate a new unique proposition")
			break
		}
	}

	// Mark the proposition as generated in the map created for tracking
	generatedPropositions[genProposition] = true
	// for debugging in CLI
	// fmt.Println("Generated proposition:", generatedPropositions)
	return genProposition
}
