# ---- Build stage ----
FROM eclipse-temurin:21-jdk AS build

WORKDIR /app

COPY gradlew .
COPY gradle gradle
RUN chmod +x gradlew

COPY build.gradle* settings.gradle* ./
RUN ./gradlew dependencies --no-daemon || true

COPY . .
RUN chmod +x gradlew
RUN ./gradlew clean build -x test --no-daemon


# ---- Run stage ----
FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=build /app/build/libs/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
