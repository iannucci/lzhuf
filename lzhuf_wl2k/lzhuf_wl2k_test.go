package lzhuf_wl2k

import (
	"testing"
)

var testdataPath = "testdata/"
var testFilename = "test1"

// Input file includes leading CRC-16 and 4 byte length in little endian format
func TestDecompressFile(t *testing.T) {
	inputFilePath := testdataPath + "/" + testFilename + ".Z"
	outputFilePath := testdataPath + "/" + testFilename + ".txt"
	data := DecompressFile(inputFilePath, outputFilePath)
	if data == nil {
		t.Errorf("Failed to decode input file")
	} else {
		t.Logf("Successfully decoded file, data length: %d bytes", len(data))
	}
}
