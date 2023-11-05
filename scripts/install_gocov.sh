#!/usr/bin/env bash
set -e

source ./scripts/versions
VERSION=$GOCOV_VERSION
echo "installing gocov v${VERSION}"

TARGET_DIR=$(pwd)/bin
mkdir -p ${TARGET_DIR}
GOBIN=${TARGET_DIR} go install github.com/axw/gocov/gocov@v${VERSION}