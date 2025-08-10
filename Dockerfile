# Stage 1 - Build the JAR (JAVA Application Runtime) using Maven

# Maven Image
FROM maven:3.8.3-openjdk-17 AS builder

# Set Working Directory
WORKDIR /app

# Copy source code from local to container
COPY . /app

# Create JAR File & skip test cases
RUN mvn clean install -DskipTests=true

# Stage 2 - APP Build

# Import small size JAVA Image
FROM openjdk:17-alpine

WORKDIR /app

# Copy build from stage 1 (builder)
COPY --from=builder /app/target/*.jar /app/target/expenseapp.jar

# Expose Application Port
EXPOSE 8080

# Start the Application
CMD ["java", "-jar", "/app/target/expenseapp.jar"]
