#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Set local docker images registery in minikube
eval $(minikube docker-env)

# Build sample-api with the host network not the bridge connection from WSL2
docker build --network=host -t http-client -f "$SCRIPT_DIR/../resources/http-client.dockerfile"  "$SCRIPT_DIR/../resources/"
# Tag image with for publish it
docker image tag http-client rltp/http-client:latest