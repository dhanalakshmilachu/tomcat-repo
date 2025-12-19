#!/bin/bash

# Log everything
exec > /var/log/userdata.log 2>&1

echo "===== USERDATA STARTED ====="

# Update
apt-get update -y

# Install required packages
apt-get install -y openjdk-11-jdk wget ca-certificates tar

# Create opt directory
mkdir -p /opt
cd /opt || exit 1

# Download Tomcat (use archive.apache.org for stability)
wget -c https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.84/bin/apache-tomcat-9.0.84.tar.gz

# Extract Tomcat
tar -xzf apache-tomcat-9.0.84.tar.gz

# Rename
mv apache-tomcat-9.0.84 tomcat9

# Permissions
chmod +x /opt/tomcat9/bin/*.sh

# Start Tomcat
/opt/tomcat9/bin/startup.sh

echo "===== USERDATA COMPLETED ====="

