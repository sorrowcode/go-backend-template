SHELL=/bin/bash -o pipefail

VERSION ?= 0.0.1
IMAGE_TAG_BASE ?= go-http-note
IMG ?= $(IMAGE_TAG_BASE):$(VERSION)

BUILD_VERSION ?= $(shell git branch --show-current)
BUILD_COMMIT ?= $(shell git rev-parse --short HEAD)
BUILD_TIMESTAMP ?= $(shell date -u '+%Y-%m-%d %H:%M:%S')

GOLDFLAGS += -X 'sorrowcode/go-http-note/internal/version.buildVersion=$(BUILD_VERSION)'
GOLDFLAGS += -X 'sorrowcode/go-http-note/internal/version.buildCommit=$(BUILD_COMMIT)'
GOLDFLAGS += -X 'sorrowcode/go-http-note/internal/version.buildTimestamp=$(BUILD_TIMESTAMP)'

#ifdef BUILD_BUILDID
#GO_TEST_VERSBOSE -v
#endif

.PHONY: format
format:
	go vet ./...
	gofmt -s -w -l ./

.PHONY: add
add: format
	git add .

.PHONY: prepare
prepare: 
	go mod tidy
	go fmt ./...
	go vet ./...

.PHONY: build
build: prepare
	go build -ldflags "$(GOLDFLAGS)" ./cmd/go-http-note/echo

DOCKER_COMPOSE = bin/docker-compose
.PHONY: docker-compose
docker-compose: $(DOCKER_COMPOSE)
$(DOCKER_COMPOSE):
	scripts/install_docker-compose.sh

GOCOV = bin/gocov
.PHONY: gocov
gocov: $(GOCOV)
$(GOCOV):
	scripts/install_gocov.sh

GOCOV_XML = bin/gocov-xml
.PHONY: gocov-xml
gocov-xml: $(GOCOV_XML)
$(GOCOV_XML):
	scripts/install_gocov-xml.sh

GOLANGCI_LINT = bin/golangci-lint
.PHONY: golangci-lint
golangci-lint: $(GOLANGCI_LINT)
$(GOLANGCI_LINT):
	scripts/install_golangci-lint.sh