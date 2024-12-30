# Use the official Java 21 JDK as the base image
FROM eclipse-temurin:21-jdk AS build

# Install required tools and Gradle
RUN apt-get update && apt-get install -y wget unzip && \
    wget https://services.gradle.org/distributions/gradle-8.3-bin.zip && \
    unzip gradle-8.3-bin.zip -d /opt/ && \
    ln -s /opt/gradle-8.3/bin/gradle /usr/bin/gradle

# Verify Gradle installation
RUN gradle --version

# Set the working directory
WORKDIR /app

# Copy Gradle files and source code
COPY build.gradle settings.gradle /app/
COPY src /app/src

# Build the application
RUN gradle bootJar -x test --no-daemon

# Use the official Java 21 runtime for the final image
FROM eclipse-temurin:21-jre

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the builder stage
COPY --from=build /app/build/libs/*.jar app.jar

# Expose the application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
