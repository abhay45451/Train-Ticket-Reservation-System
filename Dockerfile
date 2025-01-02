# Use Maven image to build the application
FROM maven:3.8-openjdk-11 AS builder

# Set the working directory for the build
WORKDIR /app

# Copy dependencies and source code
COPY pom.xml .
COPY src ./src

# Build the WAR file
RUN mvn -B -DskipTests clean package

# Use official Tomcat image for runtime
FROM tomcat:9.0-jdk11-openjdk

# Copy the WAR file to Tomcat's webapps directory
COPY --from=builder /app/target/TrainBook-1.0.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Expose the Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
