#!/usr/bin/env bash
set -e

source ./scripts/versions
VERSION=$DOCKER_COMPOSE_VERSION
echo "installing docker-compose v${VERSION}"

echo "operating system: ${OSTYPE}"
TYPE=windows
if [[ "${OSTYPE}" == linux* ]]; then
    TYPE=linux
elif [[ "${OSTYPE}" == darwin* ]]; then
    TYPE=darwin
fi

echo "cpu architecture: $(uname -m)"
case $(uname -m) in
arm64)
    ARCH=aarch64
    ;;
*)
    ARCH=x86_64
    ;;
esac

mkdir -p bin/
curl \
    --output bin/docker-compose \
    --location \
    --silent \
    https://github.com/docker/compose/releases/download/v${VERSION}/docker-compose-${TYPE}-${ARCH}

chmod +x bin/docker-compose