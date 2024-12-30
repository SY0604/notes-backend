# ===========================
# Stage 1: Build the Application
# ===========================
FROM gradle:8.2.1-jdk21 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy Gradle build files and wrapper scripts first
COPY build.gradle settings.gradle gradlew ./
COPY gradle ./gradle

# Make Gradle Wrapper executable (if using wrapper)
RUN chmod +x gradlew

# Download dependencies without building the entire project to leverage Docker caching
RUN ./gradlew build -x test --no-daemon || return 0

# Now copy the source code
COPY src ./src

# Build the application
RUN ./gradlew bootJar -x test --no-daemon

# ===========================
# Stage 2: Create the Runtime Image
# ===========================
FROM openjdk:21.0.1-jdk-slim

# Set working directory
WORKDIR /app

# Copy the Spring Boot JAR file from the build stage
COPY --from=build /app/build/libs/*.jar demo.jar

# Expose the application port
EXPOSE 8080

# Set the entrypoint to run the JAR
ENTRYPOINT ["java", "-jar", "demo.jar"]
