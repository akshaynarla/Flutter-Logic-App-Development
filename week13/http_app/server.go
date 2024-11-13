package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strings"
)

const jsonContentType = "application/json"

// JSON STEP 3: JSON data model mimicking
type Player struct {
	Name string
	Wins int
}

// Storing the Player data in the server --> allows getting the score, recording wins and leagues
type PlayerStore interface {
	GetPlayerScore(name string) int
	// STEP 10
	RecordWin(name string)
	GetLeague() []Player
}

// PlayerServer now gets the PlayerStore elements along with all the httpHandler functionality embedding
// store is an instance of the PlayerStore here.  so all PlayerStore things accessible through store.
type PlayerServer struct {
	store PlayerStore
	// router http.ServeMux is now embedded in http.Handler.
	// also means now PlayerServer now has all the functionalities of http.Handler now
	http.Handler
}

// function makes it easier to call the server than the struct. Ease of use improved here.
// NewPlayerServer returns a PlayerServer.
func NewPlayerServer(store PlayerStore) *PlayerServer {
	p := new(PlayerServer)

	p.store = store

	router := http.NewServeMux()
	router.Handle("/league", http.HandlerFunc(p.leagueHandler))
	router.Handle("/players/", http.HandlerFunc(p.playersHandler))

	p.Handler = router

	return p
}

/*func (p *PlayerServer) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	not necessary after updating the structure of the PlayerServer
	p.router.ServeHTTP(w, r)
}*/

/* / STEP 9.5: Refactoring get and post methods of http. Forms the basis of most server applications.
/ ROuting aspect is more clearer here.
func (p *PlayerServer) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	/ when http is requested, create a router
	router := http.NewServeMux()
	/we are telling the path to use the handler. This makes the test pass in the next program step.
	router.Handle("/league", http.HandlerFunc(p.leagueHandler))
	router.Handle("/players/", http.HandlerFunc(p.playersHandler))
	router.ServeHTTP(w, r)
}*/

// JSON STEP 2: Refactored the ServeHTTP to smaller functions.
func (p *PlayerServer) leagueHandler(w http.ResponseWriter, r *http.Request) {
	// JSON STEP 3
	/* leagueTable := []Player{
		{"Chris", 20},
	} */
	// JSON STEP 5 update
	w.Header().Set("content-type", jsonContentType)
	// Here encoded the table, where Chris is now added
	// Updated after JSON STEP 4
	json.NewEncoder(w).Encode(p.store.GetLeague())
	// End of STEP 3
	// w.WriteHeader(http.StatusOK)
}

// Refactoring JSON STEP 3
/* func (p *PlayerServer) getLeagueTable() []Player {
	return []Player{
		{"Chris", 20},
	}
}*/

func (p *PlayerServer) playersHandler(w http.ResponseWriter, r *http.Request) {
	player := strings.TrimPrefix(r.URL.Path, "/players/")
	// based on the http request, the correct interface will fetch data and provide it to the user or update it in the server.
	switch r.Method {
	case http.MethodPost:
		p.processWin(w, player)
	case http.MethodGet:
		p.showScore(w, player)
	}
}

func (p *PlayerServer) showScore(w http.ResponseWriter, player string) {
	// STEP 12: removes this player := strings.TrimPrefix(r.URL.Path, "/players/")
	// to show score, get the corresponding player score from server.
	score := p.store.GetPlayerScore(player)
	//  if no score for corresponding player then Status not found given.
	if score == 0 {
		w.WriteHeader(http.StatusNotFound)
	}

	fmt.Fprint(w, score)
}

func (p *PlayerServer) processWin(w http.ResponseWriter, player string) {
	// p.store.RecordWin("Bob") // Added in STEP 10
	// STEP 11: look at URL to extract the player name
	// Removed in STEP 12: player := strings.TrimPrefix(r.URL.Path, "/players/")
	p.store.RecordWin(player)

	w.WriteHeader(http.StatusAccepted)
}

/* Rewriting the below code in Step 9.5
func (p *PlayerServer) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	/ STEP 9 fix
	if r.Method == http.MethodPost {
		w.WriteHeader(http.StatusAccepted)
		return
	}

	player := strings.TrimPrefix(r.URL.Path, "/players/")
	score := p.store.GetPlayerScore(player)
	/STEP 8 Addition, which always adds this status not found. Make it conditional.
	/This will return error only if the score is 0 i.e, when there is no player
	if score == 0 {
		w.WriteHeader(http.StatusNotFound)
	}

	fmt.Fprint(w, score)
}

/* func PlayerServer(w http.ResponseWriter, r *http.Request) {
	trims away the part from /players/ to get the requested player. Not very robust.
	player := strings.TrimPrefix(r.URL.Path, "/players/")

	fmt.Fprint(w, GetPlayerScore(player))
} */

// Refactoring the score retrieval.
func GetPlayerScore(name string) string {
	if name == "Pepper" {
		return "20"
	}

	if name == "Floyd" {
		return "10"
	}

	return ""
}
