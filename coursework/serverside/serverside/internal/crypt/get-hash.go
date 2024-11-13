package crypt

import (
	"crypto/sha256"
	"encoding/hex"
)

// inspired from --> https://gobyexample.com/sha256-hashes
// Get hash value of the passed plaintext
func GetHash(plaintext string) string {
	hash := sha256.New()
	hash.Write([]byte(plaintext))
	hashBytes := hash.Sum(nil)

	hashString := hex.EncodeToString(hashBytes)
	// hashed passcode
	return hashString
}
