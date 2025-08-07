package lzhuf_wl2k

import (
	"bytes"
	"fmt"
	"io"
	"os"

	"github.com/la5nta/wl2k-go/lzhuf"
)

// Pass in file name without the .Z extension
func DecompressFile(inputFilePath string, outputFilePath string) []byte {
	inputFile, err := os.Open(inputFilePath)
	if err != nil {
		fmt.Printf("Error reading file from path %s: %v\n", inputFilePath, err)
		return nil
	}

	defer inputFile.Close() // make sure to close the file after reading

	decompressing_reader, err := lzhuf.NewB2Reader(inputFile)
	if err != nil {
		fmt.Printf("NewB2Reader creation error: %v", err)
		return nil
	}

	// The decompressing reader reads from the NewB2Reader which reads from the file.
	decompressed_data, err := io.ReadAll(decompressing_reader)
	if err != nil {
		fmt.Printf("Reading error: %v", err)
		return nil
	}

	// Write the decompressed data to a file for verification
	if len(decompressed_data) == 0 {
		fmt.Printf("No decompressed data")
		return nil
	}

	werr := os.WriteFile(outputFilePath, decompressed_data, 0644)
	if werr != nil {
		fmt.Printf("Error writing decompressed data to file %s: %v\n", outputFilePath, werr)
		return nil
	}

	return decompressed_data
}

func DecompressBuffer(buf bytes.Buffer) []byte {

	lzwReader, err := lzhuf.NewB2Reader(&buf)
	if err != nil {
		fmt.Printf("NewB2Reader error: %v", err)
		return nil
	}

	decompressed_data, err := io.ReadAll(lzwReader)
	if err != nil {
		fmt.Printf("Failed to read decompressed data: %v", err)
		return nil
	}

	return decompressed_data
}
