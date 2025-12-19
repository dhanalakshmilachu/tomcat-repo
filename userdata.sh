#!/bin/bash
set -euxo pipefail

exec > /var/log/userdata.log 2>&1

echo "===== USERDATA STARTED ====="

# Update system
apt update -y

# Install Java & tools
apt install -y openjdk-11-jdk wget ca-certificates tar

# Go to /opt
cd /opt

# Download Tomcat 9
wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.84/bin/apache-tomcat-9.0.84.tar.gz

# Extract
tar xzf apache-tomcat-9.0.84.tar.gz
mv apache-tomcat-9.0.84 tomcat9

# Permissions
chmod +x /opt/tomcat9/bin/*.sh

# START TOMCAT (do NOT delete webapps)
/opt/tomcat9/bin/startup.sh

echo "===== USERDATA COMPLETED ====="

