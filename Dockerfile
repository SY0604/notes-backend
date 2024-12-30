# Use the latest Gradle image compatible with Java 21
FROM gradle:8.3-jdk21 AS builder

# Set the working directory
WORKDIR /app

# Copy Gradle files and source code to the container
COPY build.gradle settings.gradle /app/
COPY src /app/src

# Build the application
RUN gradle build --no-daemon

# Use the official Java 21 runtime for the final image
FROM eclipse-temurin:21-jre

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the builder stage
COPY --from=builder /app/build/libs/*.jar app.jar

# Expose the application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
