#!/bin/bash
# -----------------------------
# Update packages and install Java + wget + net-tools
# -----------------------------
apt update -y
apt install -y openjdk-11-jdk wget net-tools

# -----------------------------
# Set JAVA_HOME for Tomcat
# -----------------------------
echo "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64" >> /etc/profile
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> /etc/profile
source /etc/profile

# -----------------------------
# Download and install Tomcat 9
# -----------------------------
cd /opt
wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.84/bin/apache-tomcat-9.0.84.tar.gz
tar xvf apache-tomcat-9.0.84.tar.gz
mv apache-tomcat-9.0.84 tomcat9
chmod +x /opt/tomcat9/bin/*.sh

# -----------------------------
# Download sample.war as ROOT.war
# -----------------------------
wget https://tomcat.apache.org/tomcat-8.5-doc/appdev/sample/sample.war -O /opt/tomcat9/webapps/ROOT.war

# -----------------------------
# Start Tomcat and log output
# -----------------------------
/opt/tomcat9/bin/startup.sh >> /var/log/tomcat_startup.log 2>&


