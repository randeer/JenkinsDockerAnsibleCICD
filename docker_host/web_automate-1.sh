#!/bin/bash

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
