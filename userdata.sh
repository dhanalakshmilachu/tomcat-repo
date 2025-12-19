#!/bin/bash
# Update system
apt update -y

# Install Docker
apt install docker.io -y
systemctl start docker
systemctl enable docker

# Add ubuntu user to docker group to avoid permission issues
usermod -aG docker ubuntu

# Pull pre-built Docker image from Docker Hub
docker pull dhanalakshmi16/tomcat-app:latest

# Run container exposing port 8080
docker run -d -p 8080:8080 dhanalakshmi16/tomcat-app:latest


