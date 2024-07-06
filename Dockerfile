# Use an official Maven image to build the app
FROM maven:3.6.3-openjdk-14 AS build
WORKDIR /app

# Copy the pom.xml file and the source code
COPY pom.xml .
COPY src ./src

# Package the application
RUN mvn clean package

# Use an official OpenJDK image as the base image for the runtime
FROM openjdk:14-jre-slim
WORKDIR /app

# Copy the jar file from the build stage
COPY --from=build /app/target/github-action-maven-tutorial-1.0-SNAPSHOT-jar-with-dependencies.jar app.jar

# Expose the application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
