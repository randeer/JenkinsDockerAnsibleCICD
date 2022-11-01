#!/bin/bash

DATE=$(date +%Y-%m-%d_%H:%M:%S)
REMOTE_HOST=$1
SQL_PASSWD=$2
STORAGE_ACCOUNT=$3
CONTAINER=$4
SAS_TOKEN=$5

mysqldump --column-statistics=0 -u root -h $REMOTE_HOST -p$SQL_PASSWD --all-databases > /tmp/all_databases_$DATE.sql && \

#azcopy \
#    --source /mnt/myfiles \
#    --destination https://$STORAGE_ACCOUNT.blob.core.windows.net/$CONTAINER/ \
#    --dest-key "zrUAryRaNrgfeIgE1vbeppe+WuXBmmbFQg/eNcAci5AIziCqZvHbQo4oTb7UdoZZ18AEqOazLTY0+AStTq6x4Q==" \
#   --include all_databases_$DATE.sql &&

azcopy copy "/tmp/all_databases_${DATE}.sql" "https://${STORAGE_ACCOUNT}.blob.core.windows.net/${CONTAINER}${SAS_TOKEN}" && \
rm /tmp/*