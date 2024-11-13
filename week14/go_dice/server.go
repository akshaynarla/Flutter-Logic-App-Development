package main

import (
	"encoding/json"
	"html/template"
	"net/http"
	"strconv"
)

// instance of Dice here.
// similar to the week13 exercises
type DicePair struct {
	Dice *Dice
}

// dicePairs: for holding the 10 created pairs of dice items as an array
var dicePairs []*DicePair

func NewDicePair() *DicePair {
	return &DicePair{
		Dice: NewDice(1, false),
	}
}

// for html display or stats display basically
type DiceData struct {
	PairNumber    int
	SumStatistics []int
	DieStatistics [][]int
}

// Handler function for dice
func diceHandler(w http.ResponseWriter, r *http.Request) {
	// use url to handle /dice/ and its following parts
	numOfPairs, err := strconv.Atoi(r.URL.Path[len("/dice/"):])
	// conditional check for handling <1 or >10 number of dices
	if err != nil || numOfPairs < 1 || numOfPairs > len(dicePairs) {
		http.Error(w, "Invalid pair number", http.StatusBadRequest)
		return
	}

	// handle GET or POST requests for the dice
	if r.Method == http.MethodGet {
		// GET request renders the HTML page
		renderHTML(w, numOfPairs)
	} else if r.Method == http.MethodPost {
		// throw dice when POST requested
		dicePairs[numOfPairs-1].Dice.ThrowDice()
		w.WriteHeader(http.StatusNoContent)
	} else {
		// if request is not GET or POST, throw error message
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
	}
}

// helper function for HTML rendering
func renderHTML(w http.ResponseWriter, numOfPairs int) {
	dicePair := dicePairs[numOfPairs-1]

	// Render HTML with statistics and "roll dice" button
	// ref: https://developer.mozilla.org/en-US/docs/Learn/HTML/Introduction_to_HTML/Document_and_website_structure#html_layout_elements_in_more_detail
	// ref: https://developer.mozilla.org/en-US/docs/Web/HTML/Reference
	// Also includes a button for rolling the dice --> better use of template could be done
	tmpl, err := template.New("stats").Parse(`
		<!DOCTYPE html>
		<html>
		<head>
			<title>Dice Statistics</title>
		</head>
		<body>
			<h1>Dice Statistics - Pair {{.PairNumber}}</h1>
			<h2>Sum Statistics</h2>
			<p>{{.SumStatistics}}</p>
			<h2>Die Statistics</h2>
			<table>
				{{range .DieStatistics}}
					<tr>
						{{range .}}
							<td>{{.}}</td>
						{{end}}
					</tr>
				{{end}}
			</table>
			<form action="/dice/{{.PairNumber}}" method="POST">
				<input type="submit" value="Roll Dice">
			</form>
		</body>
		</html>
	`)

	// if parsing html fails, throw error
	if err != nil {
		http.Error(w, "Error rendering template", http.StatusInternalServerError)
		return
	}

	data := DiceData{
		PairNumber:    numOfPairs,
		SumStatistics: dicePair.Dice.SumStatistics,
		DieStatistics: dicePair.Dice.DieStatistics,
	}
	// https://pkg.go.dev/html/template#Template.Execute
	// data to be parsed to the html is here
	tmpl.Execute(w, data)
}

// Handler function for statistics
func statsHandler(w http.ResponseWriter, r *http.Request) {
	// same condition as above
	numOfPairs, err := strconv.Atoi(r.URL.Path[len("/statistics/"):])
	if err != nil || numOfPairs < 1 || numOfPairs > len(dicePairs) {
		http.Error(w, "Invalid pair number", http.StatusBadRequest)
		return
	}

	// numPairs - 1 --> because array begins from 0
	dicePair := dicePairs[numOfPairs-1]
	data := DiceData{
		PairNumber:    numOfPairs,
		SumStatistics: dicePair.Dice.SumStatistics,
		DieStatistics: dicePair.Dice.DieStatistics,
	}

	if r.Method == http.MethodGet {
		// Respond with JSON containing statistics
		// No POST here since we just are displaying the stats
		serverData := data
		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(serverData)
	} else {
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
	}
}

func resetHandler(w http.ResponseWriter, r *http.Request) {
	// same condition as above
	numOfPairs, err := strconv.Atoi(r.URL.Path[len("/reset/"):])
	if err != nil || numOfPairs < 1 || numOfPairs > len(dicePairs) {
		http.Error(w, "Invalid pair number", http.StatusBadRequest)
		return
	}

	if r.Method == http.MethodPost {
		// Resetting statistics for a pair of dice
		dicePairs[numOfPairs-1].Dice.ResetStatistics()
		w.WriteHeader(http.StatusNoContent)
	} else {
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
	}
}
