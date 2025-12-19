FROM tomcat:9.0-jdk17

# Remove default Tomcat apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Download the sample WAR file directly into Tomcat
ADD https://tomcat.apache.org/tomcat-8.5-doc/appdev/sample/sample.war /usr/local/tomcat/webapps/sample.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
]
