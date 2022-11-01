#!/bin/bash


export BUILD_NUMBER=$(sed -n '1p' /tmp/.auth)
export BUILD_ID=$(sed -n '2p' /tmp/.auth)
export BUILD_TAG=$(sed -n '3p' /tmp/.auth)
export JOB_NAME=$(sed -n '4p' /tmp/.auth)


echo "Build number is $BUILD_NUMBER"

echo "Build tag is $BUILD_TAG"

echo "Job name is $JOB_NAME"

echo "Build ID is $BUILD_ID"

echo "this is the  $JOB_NAME and this is it is  $BUILD_TAG" 

echo "*****************************"
echo "******Building Jar***********"
echo "PROCESSING..................."

rm -rf /home/jenkins/code/maven
cd /home/jenkins/code/

echo "**deleting old cache.....****"
echo "**cloning new repo***********"
git clone http://manawadu:VumI3dYhgNncro@20.1.190.133:8090/jenkins/maven.git 

echo "**building jar on docker*****"

docker run --name my-maven-project -v jenkins_data-code:/usr/src/mymaven -w /usr/src/mymaven/code/maven maven:3.3-jdk-8 mvn clean install -Denforcer.skip=true > /dev/null

echo "destroying docker maven image"

docker rm my-maven-project

echo "**coping build to prod********"

cp /home/jenkins/code/maven/target/my-app-1.0-SNAPSHOT.jar /home/jenkins/code/jar/rashmika.jar

 echo "*****************************"
 echo "******Building Docker********"

docker compose build

echo "*****************************"
echo "Sending image to the repo****"

docker tag java-app:$BUILD_TAG 20.1.190.133:5000/java-maven:$BUILD_NUMBER
docker push 20.1.190.133:5000/java-maven:$BUILD_NUMBER

echo "*****************************"
echo "**Cleaning up images*********"

docker image rm java-app:$BUILD_TAG
docker image rm 20.1.190.133:5000/java-maven:$BUILD_NUMBER

echo "******************************"
echo "******Completed**************"
