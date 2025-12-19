FROM tomcat:9.0-jdk17

# Remove default apps (optional, but clean)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy built-in sample app
RUN cp -r /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
