#!/bin/bash
set -e

exec > /var/log/userdata.log 2>&1

echo "=== Installing Java ==="
apt update -y
apt install -y openjdk-11-jdk curl wget

echo "=== Installing Tomcat ==="
cd /tmp
wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.84/bin/apache-tomcat-9.0.84.tar.gz
tar -xzf apache-tomcat-9.0.84.tar.gz
mv apache-tomcat-9.0.84 /opt/tomcat
chmod +x /opt/tomcat/bin/*.sh

echo "=== Starting Tomcat ==="
/opt/tomcat/bin/startup.sh

sleep 15

echo "=== Installing Docker ==="
apt install -y ca-certificates gnupg lsb-release

mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
"deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
> /etc/apt/sources.list.d/docker.list

apt update -y
apt install -y docker-ce docker-ce-cli containerd.io
systemctl start docker
systemctl enable docker

echo "=== Building Docker image containing WAR ==="
mkdir -p /opt/war-source
cd /opt/war-source

cat <<'EOF' > Dockerfile
FROM tomcat:8.5-jdk11
RUN rm -rf /usr/local/tomcat/webapps/*
RUN curl -fSL -o /sample.war \
https://tomcat.apache.org/tomcat-8.5-doc/appdev/sample/sample.war
EOF

docker build -t war-image .

echo "=== Extracting WAR from Docker ==="
docker create --name war-container war-image
docker cp war-container:/sample.war /opt/tomcat/webapps/sample.war
docker rm war-container

echo "=== Restarting Tomcat ==="
/opt/tomcat/bin/shutdown.sh || true
sleep 5
/opt/tomcat/bin/startup.sh

echo "=== DONE ==="


