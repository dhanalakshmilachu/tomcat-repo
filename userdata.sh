#!/bin/bash
# Update system
apt update -y
apt install openjdk-21-jdk wget -y

# Download Tomcat
cd /opt
wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.84/bin/apache-tomcat-9.0.84.tar.gz
tar xvf apache-tomcat-9.0.84.tar.gz
mv apache-tomcat-9.0.84 tomcat9
chmod +x /opt/tomcat9/bin/*.sh

# Download sample.war as ROOT.war
wget https://tomcat.apache.org/tomcat-8.5-doc/appdev/sample/sample.war -O /opt/tomcat9/webapps/ROOT.war

# Start Tomcat
/opt/tomcat9/bin/startup.sh


