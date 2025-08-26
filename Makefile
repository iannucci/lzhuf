# Makefile for cross-building Go binaries for macOS and Linux
# Adjust APP_NAME as needed
APP_NAME := decompress_lzhuf
SRC := main/decompress_lzhuf.go
BUILD_DIR := main/build
INSTALL_PATH := /usr/local/bin

# Target platforms and architectures
TARGETS := \
	linux_amd64 \
	darwin_amd64 \
	darwin_arm64

# Default target
all: $(TARGETS)

# Cross-compile targets
linux_amd64:
	GOOS=linux GOARCH=amd64 go build -o $(BUILD_DIR)/$(APP_NAME)-linux $(SRC)

darwin_amd64:
	GOOS=darwin GOARCH=amd64 go build -o $(BUILD_DIR)/$(APP_NAME)-mac-x86 $(SRC)

darwin_arm64:
	GOOS=darwin GOARCH=arm64 go build -o $(BUILD_DIR)/$(APP_NAME)-mac-arm $(SRC)

# Install on current system
install: detect_os
	@echo "Installing $(APP_NAME) to $(INSTALL_PATH)..."
	@cp $(BIN_TO_INSTALL) $(INSTALL_PATH)/$(APP_NAME)
	@chmod +x $(INSTALL_PATH)/$(APP_NAME)
	@echo "Installed successfully: $(INSTALL_PATH)/$(APP_NAME)"

# Detect the current platform and select binary
detect_os:
	$(eval OS := $(strip $(shell uname -s)))
	$(eval ARCH_RAW := $(strip $(shell uname -m)))
	$(eval ARCH := $(strip $(shell echo "$(ARCH_RAW)" | sed \
		-e 's/x86_64/amd64/' \
		-e 's/aarch64/arm64/' \
		-e 's/arm64/arm64/' )))
	$(eval BIN_SUFFIX := $(strip $(call map_os_arch,$(OS),$(ARCH))))
	$(eval BIN_TO_INSTALL := $(strip $(BUILD_DIR)/$(APP_NAME)-$(BIN_SUFFIX)))
	$(info [INFO] OS = $(OS), ARCH_RAW = $(ARCH_RAW), ARCH = $(ARCH))
	$(info [INFO] Looking for binary file: $(BIN_TO_INSTALL))
	@if [ ! -f "$(BIN_TO_INSTALL)" ]; then \
		echo "Error: Binary not built for this platform: $(OS)/$(ARCH)"; \
		exit 1; \
	fi

# Mapping function to produce suffixes
define map_os_arch
$(info [DEBUG] For OS=$(1), ARCH=$(2)) \
$(if $(filter $(1),Linux),linux, \
$(if $(filter $(1),Darwin), \
  $(if $(filter $(2),x86_64),mac-x86, \
  $(if $(filter $(2),arm64),mac-arm,unknown)),unknown))
endef

# Clean
clean:
	rm -rf $(BUILD_DIR)

# Ensure build directory exists
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

.PHONY: all clean install detect_os linux_amd64 darwin_amd64 darwin_arm64