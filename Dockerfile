# Use official Tomcat image with OpenJDK 17 as the base for running the application
FROM tomcat:9.0-jdk17-openjdk

# Set the working directory for the deployment
WORKDIR /usr/local/tomcat/webapps

# Copy the locally built WAR file into the Tomcat webapps directory as ROOT.war
COPY ./target/TrainBook-1.0.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Set permissions to make startup.sh executable (Tomcat's bin folder)
RUN chmod +x /usr/local/tomcat/bin/catalina.sh

# Set permissions to make the WAR file executable (optional, as WARs usually don't need executable flag, but it's safe to ensure permissions)
RUN chmod 644 /usr/local/tomcat/webapps/ROOT.war

# Expose the port that Tomcat runs on
EXPOSE 8080

# Start Tomcat when the container starts
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
