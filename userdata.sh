#!/bin/bash
apt update -y
apt install docker.io -y
systemctl start docker
systemctl enable docker

# Clone repo
cd /home/ubuntu
git clone https://github.com/dhanalakshmilachu/tomcat-repo.git

# Build Docker image
docker build -t tomcat-app ./tomcat-repo

# Run container mapping port 8080
docker run -d -p 8080:8080 tomcat-app

