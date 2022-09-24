#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

kubectl apply -f "$SCRIPT_DIR/../kubernetes/http-client-pod.yaml"
