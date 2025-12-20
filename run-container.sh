#!/bin/bash

# Build Docker image
docker build -t tomcat-sample .

# Run container mapping host port 8080 to container 8080
docker run -d -p 8080:8080 --name tomcat-sample-app tomcat-sample

