package main

//in_memory_player_store.go
func NewInMemoryPlayerStore() *InMemoryPlayerStore {
	return &InMemoryPlayerStore{map[string]int{}}
}

// More or less copied the structure from main.go to handle the struct things.
type InMemoryPlayerStore struct {
	store map[string]int
}

// Update the count of the parsed player when the function is called.
func (i *InMemoryPlayerStore) RecordWin(name string) {
	i.store[name]++
}

// returns the player score based on the parsed player.
func (i *InMemoryPlayerStore) GetPlayerScore(name string) int {
	return i.store[name]
}

// After JSON STEP 4
func (i *InMemoryPlayerStore) GetLeague() []Player {
	return nil
}
