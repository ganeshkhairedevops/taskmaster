#!/bin/bash

echo "Starting port forward for TaskMaster Pro..."
echo "Access the application at: http://localhost:80"
echo "Press Ctrl+C to stop port forwarding"

kubectl port-forward -n taskmaster service/taskmaster-app 80:80
