# openjdk11을 베이스로 이미지를 만든다.
FROM openjdk:11-jdk-slim

# JAR_FILE 변수에 jar 파일을 등록
ARG JAR_FILE=/build/libs/show-service-0.0.1-SNAPSHOT.jar

# build 된 jar 파일을 container 내부에 복사
# 젠킨스 도커 -> 스프링 도커
COPY ${JAR_FILE} ./app.jar

EXPOSE 8082

# jasypt 암호화 키 제공하려면
#ENTRYPOINT ["sh", "-c", "java ${JAVA_OPTS} -jar /app.jar"]
