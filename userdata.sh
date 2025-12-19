#!/bin/bash
set -euxo pipefail

# Log everything
exec > /var/log/userdata.log 2>&1

echo "===== USERDATA STARTED ====="

# Update system
apt update -y

# Install Java, wget, ca-certificates
apt install -y openjdk-11-jdk wget ca-certificates tar

# Verify Java
java -version

# Go to /opt
cd /opt

# Download Tomcat 9
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.113/bin/apache-tomcat-9.0.113.tar.gz

# Extract Tomcat
tar -xvf apache-tomcat-9.0.113.tar.gz

# Rename directory
mv apache-tomcat-9.0.113.tar.gz tomcat
chown -R ubuntu:ubuntu /opt/tomcat
# Make scripts executable
chmod +x /opt/tomcat9/bin/*.sh

# Remove default apps
rm -rf /opt/tomcat9/webapps/*

# Download sample.war as ROOT.war
wget https://tomcat.apache.org/tomcat-8.5-doc/appdev/sample/sample.war \
     -O /opt/tomcat9/webapps/ROOT.war

# Start Tomcat
/opt/tomcat9/bin/startup.sh

echo "===== USERDATA COMPLETED ====="

