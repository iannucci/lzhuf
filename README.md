# lzhuf

LZH code from [la5nta/wl2k-go](https://github.com/la5nta/wl2k-go) to perform decompression of Winlink messages, wrapped so that it can be called from Python.  A binary executable of the go code will be installed (supported on Linux x86, Mac x86 and Mac ARM64).  Sorry, Windows.

## Installation

Clone this repo to `\<dir>`

```
$ cd <dir>
$ make clean
$ make
$ sudo make install
```

## Usage

From Python:

```
import subprocess
import platform
import os

def get_go_binary():
    system = platform.system()
	machine = platform.machine()

	if system == "Linux":
	    return "./decompress-linux"
	elif system == "Darwin" and machine == "x86_64":
		return "./decompress-mac"
	elif system == "Darwin" and machine == "arm64":
		return "./decompress-mac-arm"
	else:
		raise RuntimeError(f"Unsupported platform: {system} {machine}")

def decompress_lzhuf(inputFilePath, outputFilePath):
	binary = get_go_binary()
	result = subprocess.run([binary, inputFilePath, outputFilePath], capture_output=True, text=True)
	return result.stdout.strip()
```
