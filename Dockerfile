FROM openjdk:11 AS BUILD_IMAGE
WORKDIR /usr/src/app/

RUN apt update && apt install maven -y
COPY ./ /usr/src/app/
#RUN git clone https://github.com/devopshydclub/vprofile-project.git
RUN echo "Rohin" && pwd && whoami && ls
RUN mvn install -DskipTests

FROM tomcat:9-jre11
WORKDIR /usr/src/app/

RUN rm -rf /usr/local/tomcat/webapps/*

RUN echo "Rohin Runtime" && pwd && whoami && ls
COPY --from=BUILD_IMAGE /usr/src/app/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
