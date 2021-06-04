GOOS ?= $(shell uname -s | tr A-Z a-z)
GOARCH ?= amd64
GOMAIN ?= main.go
BUILD_DIR ?= bin
BUILD_NAME = drone-runner-exec

build:
	@echo "Building release binary for $(GOOS)-$(GOARCH)..."
	@go version
	@export BUILD_NAME=$(BUILD_NAME)
	@if [[ "$(GOOS)" = "windows" ]]; then \
		export BUILD_NAME=$(BUILD_NAME).exe; \
	fi
	@echo
	@env \
		GOOS=$(GOOS) \
		GOARCH=$(GOARCH) \
		CGO_ENABLED=1 \
		GO111MODULE=on \
			go build -v \
				-tags netgo \
				-ldflags "\
					-s -w \
				" \
				-a -o $(BUILD_DIR)/$$BUILD_NAME $$GOMAIN
	@echo
	@ls -ogh $(BUILD_DIR)/$$BUILD_NAME
	@echo
.PHONY: build
