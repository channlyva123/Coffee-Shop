# ---- Build Stage ----
FROM gradle:8-jdk21 AS build

WORKDIR /app

# Copy Gradle wrapper FIRST
COPY gradlew .
COPY gradle gradle

# Make gradlew executable
RUN chmod +x gradlew

# Copy Gradle config files
COPY build.gradle* .
COPY settings.gradle* .

# Pre-download dependencies (optional)
RUN ./gradlew dependencies --no-daemon || true

# Copy the rest of the project
COPY . .

# Ensure gradlew is executable after copying everything
RUN chmod +x gradlew

# Build the project (skip tests)
RUN ./gradlew clean build -x test --no-daemon


# ---- Run Stage ----
FROM eclipse-temurin:21-jre

WORKDIR /app

# Copy the built jar from build stage
COPY --from=build /app/build/libs/*.jar app.jar

EXPOSE 8080

# Run the app
CMD ["java", "-jar", "app.jar"]
