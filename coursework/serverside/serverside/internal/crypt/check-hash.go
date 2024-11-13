package crypt

// hashes the supplied plaintext string and checks equality with the supplied hash
// https://gobyexample.com/sha256-hashes
func CheckHash(hashStored, plaintext string) bool {

	hashString := GetHash(plaintext)

	if hashStored == hashString {
		return true
	} else {
		return false
	}
}
