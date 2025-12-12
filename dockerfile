# ================================
# 1. BUILD STAGE
# ================================
FROM gradle:8-jdk17 AS build
WORKDIR /app

# Copy Gradle wrapper and config first (to improve caching)
COPY gradlew .
COPY gradle gradle
COPY build.gradle* .
COPY settings.gradle* .

# Download dependencies
RUN ./gradlew dependencies --no-daemon || true

# Copy the rest of the project
COPY . .

# Build the application (creates a fat JAR)
RUN ./gradlew clean build -x test --no-daemon


# ================================
# 2. RUN STAGE
# ================================
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copy generated jar from the build stage
COPY --from=build /app/build/libs/*.jar app.jar

# Expose port 8080 (Render will map automatically)
EXPOSE 8080

# Start the server
ENTRYPOINT ["java", "-jar", "app.jar"]
