#!/bin/bash

echo "Deploying TaskMaster Pro to Kubernetes..."

# Apply all manifests in order
kubectl apply -f 01.namespace.yml
kubectl apply -f 02.secret.yml
kubectl apply -f 03.configmap.yaml
kubectl apply -f 04.pv.yaml
kubectl apply -f 05.pvc.yaml
kubectl apply -f 06.postgres-deployment.yaml
kubectl apply -f 07.postgres-service.yaml
kubectl apply -f 08.app-deployment.yaml
kubectl apply -f 09.app-service.yaml

echo "Waiting for deployments to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/taskmaster-db -n taskmaster
kubectl wait --for=condition=available --timeout=300s deployment/taskmaster-app -n taskmaster

echo "Getting service information..."
kubectl get services -n taskmaster

echo "Deployment complete!"
