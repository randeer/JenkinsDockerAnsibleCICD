#!/bin/bash


export BUILD_NUMBER=$(sed -n '1p' /tmp/.auth)
export BUILD_ID=$(sed -n '2p' /tmp/.auth)
export BUILD_TAG=$(sed -n '3p' /tmp/.auth)
export JOB_NAME=$(sed -n '4p' /tmp/.auth)

echo "*********************Building the website************************************************"

docker run --name website-build -v jenkins_data-code:/usr/src/mymaven -w /usr/src/mymaven/code/java_tomcat maven:3.3-jdk-8 mvn clean install -Denforcer.skip=true > /dev/null

echo "***************************Removing the cache********************************************"

docker rm website-build

echo "*************************Copying the WAR to folder***************************************"

cp /home/jenkins/code/java_tomcat/target/java-tomcat-maven-example.war /home/jenkins/code/website/ROOT.war

echo "*****************************************************************************************"

