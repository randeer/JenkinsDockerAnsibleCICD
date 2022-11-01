#!/bin/bash

echo "****************************************************************************************"
echo "****************************************************************************************"

echo "*****************AUTOMATION STARTED*****************************************************"

export BUILD_NUMBER=$(sed -n '1p' /tmp/.auth)
export BUILD_ID=$(sed -n '2p' /tmp/.auth)
export BUILD_TAG=$(sed -n '3p' /tmp/.auth)
export JOB_NAME=$(sed -n '4p' /tmp/.auth)

echo "*****************************Checking Changes********************************************"

rm -rf /home/jenkins/code/java_tomcat
cd /home/jenkins/code/

echo "**********************Cloning the repo***************************************************"

git clone http://manawadu:VumI3dYhgNncro@20.1.190.133:8090/jenkins/java_tomcat.git

echo "************************Cloned the latest repo*******************************************"
echo "*********************Building the website************************************************"

docker run --name website-build -v jenkins_data-code:/usr/src/mymaven -w /usr/src/mymaven/code/java_tomcat maven:3.3-jdk-8 mvn clean install -Denforcer.skip=true > /dev/null

echo "***************************Removing the cache********************************************"

docker rm website-build

echo "*************************Copying the WAR to folder***************************************"

cp /home/jenkins/code/java_tomcat/target/java-tomcat-maven-example.war /home/jenkins/code/website/index.war

echo "************************Building Docker Image********************************************"

docker compose -f cv-website.yml build

echo "***********************Built the docker image********************************************"

echo "************************Pushing the created image to the registry************************"

docker tag randeer-cv:$BUILD_TAG 20.1.190.133:5000/randeer-cv:$BUILD_NUMBER
docker push 20.1.190.133:5000/randeer-cv:$BUILD_NUMBER

echo "********************TASK COMPLETED*******************************************************"
echo "*****************************************************************************************"
echo "*****************************************************************************************"
