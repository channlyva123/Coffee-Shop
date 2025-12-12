# ---- Build Stage ----
FROM gradle:8-jdk17 AS build

WORKDIR /app

# Copy Gradle Wrapper first (better caching)
COPY gradlew .
COPY gradle gradle
COPY build.gradle* .
COPY settings.gradle* .

# Fix: Allow gradlew to run
RUN chmod +x gradlew

# Pre-download dependencies (so future builds are faster)
RUN ./gradlew dependencies --no-daemon || true

# Copy source code
COPY . .

# Build the application (fat JAR)
RUN ./gradlew clean build -x test --no-daemon


# ---- Run Stage ----
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copy built jar
COPY --from=build /app/build/libs/*.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
