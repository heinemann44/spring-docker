# Use an official Maven image to build the application
FROM maven:3.8.4-openjdk-17-slim AS build

# Set the working directory to /app
WORKDIR /app

# Copy the POM file first for better caching
COPY pom.xml .

# Download the dependencies
RUN mvn dependency:go-offline -B

# Copy the project files and build the application
COPY src src
RUN mvn package -DskipTests

# Use an official OpenJDK runtime as a parent image
FROM openjdk:17

# Set the working directory to /app
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/spring-docker-0.0.1-SNAPSHOT.jar /app/spring-docker-0.0.1-SNAPSHOT.jar

# Expose the port that your application will run on
EXPOSE 8080

# Define environment variables for PostgreSQL connection
ENV SPRING_DATASOURCE_URL=jdbc:postgresql://database:5432/local_database
ENV SPRING_DATASOURCE_USERNAME=local_user
ENV SPRING_DATASOURCE_PASSWORD=local_password
ENV SPRING_DATASOURCE_DRIVER_CLASS_NAME=org.postgresql.Driver

# Command to run your application
CMD ["java", "-jar", "spring-docker-0.0.1-SNAPSHOT.jar"]
