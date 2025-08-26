# lzhuf

LZH code from [la5nta/wl2k-go](https://github.com/la5nta/wl2k-go) to perform decompression of Winlink messages, wrapped so that it can be called from Python.  

> [!NOTE] 
> Pre-built binaries of the go code are included for Linux x86, Mac x86 and Mac ARM64.  But you can certainly build your own.

## Installation

Clone this repo to `<dir>`

```
$ cd <dir>
$ make
$ sudo make install
```

## Usage

From Python:

```
import subprocess

GO_EXECUTABLE = "./decompress_lzhuf"

def decompress_lzhuf(inputFilePath, outputFilePath):
	binary = get_go_binary()
	result = subprocess.run([GO_EXECUTABLE, inputFilePath, outputFilePath], capture_output=True, text=True)
	return result.stdout.strip()
```

Everyone should decompress regularly.