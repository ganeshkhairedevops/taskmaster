#!/bin/bash

# Replace 'your-dockerhub-username' with your actual Docker Hub username
DOCKERHUB_USERNAME="your-dockerhub-username"

echo "Building and pushing TaskMaster to Docker Hub..."

# Build the image
docker build -t taskmaster:latest .

# Tag for Docker Hub
docker tag taskmaster:latest $DOCKERHUB_USERNAME/taskmaster:latest

# Login to Docker Hub (you'll be prompted for credentials)
docker login

# Push to Docker Hub
docker push $DOCKERHUB_USERNAME/taskmaster:latest

echo "Image pushed to Docker Hub: $DOCKERHUB_USERNAME/taskmaster:latest"
echo "Update the deployment file with your username and apply:"
