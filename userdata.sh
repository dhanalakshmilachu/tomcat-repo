#!/bin/bash
set -e

# Log everything for debugging
exec > /var/log/userdata.log 2>&1

echo "Starting userdata script..."

# Update system
apt update -y

# Install Java 11
apt install -y openjdk-11-jdk wget

# Create tomcat user
useradd -m -U -d /opt/tomcat -s /bin/false tomcat

# Download Tomcat 9
cd /tmp
wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.84/bin/apache-tomcat-9.0.84.tar.gz

# Extract Tomcat
mkdir -p /opt/tomcat
tar -xzf apache-tomcat-9.0.84.tar.gz -C /opt/tomcat --strip-components=1

# Set permissions
chown -R tomcat:tomcat /opt/tomcat
chmod +x /opt/tomcat/bin/*.sh

# Create systemd service for Tomcat
cat <<EOF >/etc/systemd/system/tomcat.service
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking
User=tomcat
Group=tomcat
Environment=JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd
systemctl daemon-reexec
systemctl daemon-reload

# Start Tomcat
systemctl enable tomcat
systemctl start tomcat

# Wait for Tomcat to fully start
sleep 20

# Deploy sample WAR
cd /opt/tomcat/webapps
wget https://tomcat.apache.org/tomcat-8.5-doc/appdev/sample/sample.war
chown tomcat:tomcat sample.war

# Restart Tomcat to deploy WAR
systemctl restart tomcat

echo "Userdata script completed successfully"

