package model

import (
	"bytes"
	"encoding/json"
	"fmt"
	"os"
	"strings"
)

// WriteToJson marshals data into JSON and saves it to a specified file.
func WriteToJson(data interface{}, filename string) error {
	jsonData, err := json.MarshalIndent(data, "", "    ")
	if err != nil {
		return fmt.Errorf("error marshaling JSON: %w", err)
	}

	// https://stackoverflow.com/questions/54648117/escape-unicode-characters-in-json-encode-golang
	// convert jsonData to a string and unescape specific characters
	jsonString := string(jsonData)
	jsonString = strings.ReplaceAll(jsonString, "\\u0026", "&")

	jsonReader := bytes.NewBufferString(jsonString)

	file, err := os.Create(filename)
	if err != nil {
		return fmt.Errorf("error creating json file: %w", err)
	}
	defer file.Close()

	// Write the unescaped JSON string to file
	_, err = file.ReadFrom(jsonReader)
	if err != nil {
		return fmt.Errorf("error writing JSON data to file: %w", err)
	}

	return nil
}
