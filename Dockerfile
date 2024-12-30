# Use the official Gradle image as a builder with JDK 17 as a fallback
FROM gradle:7.6.0-jdk17 AS builder

# Install Java 21 manually
RUN apt-get update && apt-get install -y wget && \
    wget https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.tar.gz && \
    tar -xzf jdk-21_linux-x64_bin.tar.gz -C /usr/local && \
    update-alternatives --install /usr/bin/java java /usr/local/jdk-21/bin/java 1 && \
    update-alternatives --install /usr/bin/javac javac /usr/local/jdk-21/bin/javac 1

# Verify Java version
RUN java -version

# Set the working directory
WORKDIR /app

# Copy Gradle files and source code
COPY build.gradle settings.gradle /app/
COPY src /app/src

# Build the application
RUN gradle build --no-daemon

# Use the official Java 21 runtime as the base for the final image
FROM eclipse-temurin:21-jre

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the builder stage
COPY --from=builder /app/build/libs/*.jar app.jar

# Expose the application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
