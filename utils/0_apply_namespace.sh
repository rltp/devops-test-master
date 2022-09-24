#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

#Apply the namespace ressource
kubectl apply -f "$SCRIPT_DIR/../kubernetes/namespace.yaml"