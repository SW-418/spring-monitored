FROM eclipse-temurin:21-jdk-jammy AS build

WORKDIR /app

COPY build.gradle.kts settings.gradle.kts gradlew ./
COPY gradle ./gradle

RUN curl -L https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/latest/download/opentelemetry-javaagent.jar -o /app/opentelemetry-javaagent.jar

RUN ./gradlew dependencies

COPY src ./src
COPY src/main/resources/log4j2.xml /app/log4j2.xml

RUN ./gradlew build -x test

FROM eclipse-temurin:21-jre-jammy AS run

WORKDIR /app

COPY --from=build /app/opentelemetry-javaagent.jar /opentelemetry-javaagent.jar
COPY --from=build /app/build/libs/spring-monitored-*.jar /app.jar
COPY --from=build /app/log4j2.xml /app/log4j2.xml

ENV JAVA_TOOL_OPTIONS="-javaagent:/opentelemetry-javaagent.jar"
ENV OTEL_SERVICE_NAME=spring-monitored
ENV OTEL_EXPORTER_OTLP_ENDPOINT=http://datadog:4318
ENV OTEL_RESOURCE_ATTRIBUTES="env=local"

ENTRYPOINT ["java", "-jar", "/app.jar"]
