# Stage 1: Build the application
FROM maven:3.8.6-jdk-11 AS build
WORKDIR /app

# Copy pom.xml and download dependencies to cache them
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy source code and build the application
COPY src ./src
RUN mvn clean package

# Stage 2: Runtime image
FROM tomcat:9.0-jdk11
WORKDIR /usr/local/tomcat

# Remove default Tomcat webapps
RUN rm -rf webapps/*

# Copy the built WAR file from the build stage, renaming to ROOT.war so it serves at /
COPY --from=build /app/target/*.war webapps/ROOT.war

# Expose the port (Render sets the PORT environment variable)
EXPOSE 8080

# Configure Tomcat to bind to 0.0.0.0 and listen on the $PORT environment variable at runtime.
CMD sed -i -e "s/port=\"8080\"/port=\"$PORT\"/g" /usr/local/tomcat/conf/server.xml && catalina.sh run
