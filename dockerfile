# ---- Build Stage ----
FROM gradle:8-jdk17 AS build

WORKDIR /app

# Copy Gradle wrapper and allow execution
COPY gradlew .
COPY gradle gradle
RUN chmod +x gradlew

# Copy build files
COPY build.gradle* .
COPY settings.gradle* .

# Download dependencies
RUN ./gradlew dependencies --no-daemon || true

# Copy source
COPY . .

# Build
RUN ./gradlew clean build -x test --no-daemon


# ---- Run Stage ----
FROM eclipse-temurin:17-jre

WORKDIR /app

COPY --from=build /app/build/libs/*.jar app.jar

EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
