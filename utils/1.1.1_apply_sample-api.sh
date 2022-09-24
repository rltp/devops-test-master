#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Create the pod and the services associed (NodePort for access it from the browser and ClusterIP for http-client)
kubectl apply -f "$SCRIPT_DIR/../kubernetes/sample-api-pod.yaml"
kubectl apply -f "$SCRIPT_DIR/../kubernetes/sample-api-services.yaml"
