#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

#Create a persistant Mongodb instances
kubectl apply -f "$SCRIPT_DIR/../kubernetes/mongo-storageclass.yaml"
kubectl apply -f "$SCRIPT_DIR/../kubernetes/mongo-pv.yaml"
kubectl apply -f "$SCRIPT_DIR/../kubernetes/mongo-pvc.yaml"
kubectl apply -f "$SCRIPT_DIR/../kubernetes/mongo-secrets.yaml"
kubectl apply -f "$SCRIPT_DIR/../kubernetes/mongo-deployment.yaml"
kubectl apply -f "$SCRIPT_DIR/../kubernetes/mongo-service.yaml"