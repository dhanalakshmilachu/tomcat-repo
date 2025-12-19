# Use official Tomcat 8.5 image with JDK 11
FROM tomcat:8.5-jdk11

# Clean default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Download sample.war into Tomcat webapps
RUN wget -O /usr/local/tomcat/webapps/sample.war \
    https://tomcat.apache.org/tomcat-8.5-doc/appdev/sample/sample.war

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
