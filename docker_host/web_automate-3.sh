#!/bin/bash


export BUILD_NUMBER=$(sed -n '1p' /tmp/.auth)
export BUILD_ID=$(sed -n '2p' /tmp/.auth)
export BUILD_TAG=$(sed -n '3p' /tmp/.auth)
export JOB_NAME=$(sed -n '4p' /tmp/.auth)

echo "************************Building Docker Image********************************************"

docker compose -f /home/jenkins/code/cv-website.yml build

echo "***********************Built the docker image********************************************"


echo "*****************************************************************************************"
