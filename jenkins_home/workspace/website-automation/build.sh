#!/bin/bash

echo $BUILD_NUMBER > /tmp/.auth
echo $BUILD_ID >> /tmp/.auth
echo $BUILD_TAG >> /tmp/.auth
echo $JOB_NAME >> /tmp/.auth

scp -i /var/jenkins_home/ansible/dias_key /tmp/.auth root@docker-host:/tmp/.auth

echo "Build Task is completed"
