#!/bin/bash

echo "Cleaning up TaskMaster Pro from Kubernetes..."

kubectl delete namespace taskmaster

echo "Cleanup complete!"
