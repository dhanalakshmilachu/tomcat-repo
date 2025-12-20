FROM tomcat:8.5-jdk11

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Download sample.war inside Docker image
RUN curl -fSL -o /sample.war \
https://tomcat.apache.org/tomcat-8.5-doc/appdev/sample/sample.war
