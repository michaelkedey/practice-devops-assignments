# Use an official Maven image as a base for building the application
FROM maven:3.8.4-openjdk-11 AS builder

# Copy the Maven project and build the application
COPY . /app
WORKDIR /app
RUN mvn clean package

# Use Tomcat as the base image for runtime
FROM tomcat:8.0.20-jre8

# Copy the WAR file built by Maven into the Tomcat webapps directory
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/
