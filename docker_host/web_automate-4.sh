#!/bin/bash

export BUILD_NUMBER=$(sed -n '1p' /tmp/.auth)
export BUILD_ID=$(sed -n '2p' /tmp/.auth)
export BUILD_TAG=$(sed -n '3p' /tmp/.auth)
export JOB_NAME=$(sed -n '4p' /tmp/.auth)

echo "************************Pushing the created image to the registry************************"

docker tag randeerlalanga-cv:$BUILD_TAG 20.1.190.133:5000/randeerlalanga-cv:$BUILD_NUMBER
docker push 20.1.190.133:5000/randeerlalanga-cv:$BUILD_NUMBER

echo "********************TASK COMPLETED*******************************************************"
echo "*****************************************************************************************"
echo "*****************************************************************************************"
                                                                                                      
