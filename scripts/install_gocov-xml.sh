#!/usr/bin/env bash
set -e

source ./scripts/versions
VERSION=$GOCOV_XML_VERSION
echo "installing gocov-xml v${VERSION}"

TARGET_DIR=$(pwd)/bin
mkdir -p ${TARGET_DIR}
GOBIN=${TARGET_DIR} go install github.com/AlekSi/gocov-xml@v${VERSION}