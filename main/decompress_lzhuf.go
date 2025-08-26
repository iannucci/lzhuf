package main

import (
	"fmt"
	"os"

	"github.com/iannucci/lzhuf/lzhuf_wl2k"
)

func main() {
	if len(os.Args) < 3 {
		fmt.Println("Input and output paths must be specified")
		return
	}
	inputFilePath := os.Args[1]
	outputFilePath := os.Args[2]
	lzhuf_wl2k.DecompressFile(inputFilePath, outputFilePath)
	fmt.Printf("Decompressed successfully")
}
