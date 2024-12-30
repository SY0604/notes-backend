# Use the official Gradle image with JDK 17 for building
FROM gradle:7.6.0-jdk17 AS builder

# Set the working directory
WORKDIR /app

# Copy project files
COPY build.gradle settings.gradle /app/
COPY src /app/src

# Build the application
RUN gradle build --no-daemon

# Use the official Java 21 runtime as the base image
FROM eclipse-temurin:21-jre

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the builder stage
COPY --from=builder /app/build/libs/*.jar app.jar

# Expose the application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
