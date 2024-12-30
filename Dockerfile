# Stage 1: Build the application
FROM openjdk:21-jdk AS build

# Set the working directory
WORKDIR /app

# Copy Gradle wrapper and project files
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .
COPY src src

# Grant execute permissions for Gradle wrapper
RUN chmod +x gradlew

# (Optional) Cache dependencies
RUN ./gradlew dependencies --no-daemon

# Build the application
RUN ./gradlew bootJar -x test --no-daemon --warning-mode all

# Stage 2: Run the application
FROM openjdk:21-jdk

# Set the working directory
WORKDIR /app

# Copy the built JAR from the build stage
COPY --from=build /app/build/libs/*.jar app.jar

# Specify the entry point
ENTRYPOINT ["java", "-jar", "app.jar"]
