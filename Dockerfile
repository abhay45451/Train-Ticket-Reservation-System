# Use Maven image with OpenJDK 17 to build the application
FROM maven:3.8-openjdk-17 AS builder

# Set the working directory for the build
WORKDIR /app

# Copy the pom.xml and source code into the container
COPY pom.xml . 
COPY src ./src

# Build the WAR file (skip tests for faster builds)
RUN mvn clean package -DskipTests

# Use official Tomcat image with OpenJDK 17 as the base for running the application
FROM tomcat:9.0-jdk17-openjdk

# Copy the WAR file from the builder image to Tomcat's webapps directory as ROOT.war
COPY --from=builder /app/target/TrainBook-1.0.0-SNAPSHOT.war /usr/local/tomcat/webapps/

# Expose the port that Tomcat runs on
EXPOSE 8080

# Start Tomcat when the container starts
CMD ["catalina.sh", "run"]
