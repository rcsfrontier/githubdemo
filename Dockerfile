FROM openjdk:21-slim AS builder
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .
COPY BroadcastProductService BroadcastProductService
RUN chmod +x ./gradlew
RUN ./gradlew build

FROM openjdk:21-slim
WORKDIR /usr/src/demo
RUN groupadd  -r spring && useradd  -g spring spring
USER spring:spring
COPY --from=builder /BroadcastProductService/build/libs/*.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]