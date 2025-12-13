# Use OpenJDK 21
FROM eclipse-temurin:21-jdk-alpine

WORKDIR /app

# Copy Gradle wrapper and project files
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .
COPY src src

# Make gradlew executable
RUN chmod +x ./gradlew

# Build the Spring Boot jar
RUN ./gradlew clean bootJar -x test --no-daemon

# Run the application
CMD ["java", "-jar", "build/libs/coffee-shop-0.0.1-SNAPSHOT.jar"]
