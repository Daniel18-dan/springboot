FROM ubuntu AS build 

WORKDIR /springboot_app

COPY . .

RUN apt-get update && apt-get install openjdk-17-jdk -y && apt-get install maven -y
RUN mvn clean package

FROM openjdk:17-jdk-alpine

WORKDIR /app

COPY --from=build /springboot_app/target/*.jar app.jar

EXPOSE 9090
CMD ["java", "-jar", "app.jar"]


