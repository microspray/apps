#!/usr/bin/env bash

# 1. Copy baseconfig to /data/redis.conf if doesn't exists
# 2. Sed values in /data/redis.conf
# 3. print /data/redis.conf

REDIS_NAME=${REDIS_NAME:-"myMaster"}
REDIS_MASTER=${REDIS_INITIAL_MASTER_HOST:-"localost"}
QUORUM=${QUORUM:-"2"}
POD_FQDN=${POD_FQDN:-"localhost"}
REDISCONF=${REDISCONF:-"/data/conf/redis.conf"}

initconf=$1
confdest=$2
overwrite="no"
if [ $# == 3 ]; then
    overwrite=$3
fi

echo "$initconf $confdest" "$overwrite"
mkdir -p $(dirname $confdest)

if [ ! -f $confdest ] || [[ "$overwrite" == "yes" ]]; then
    cp $initconf $confdest
fi

if [ -f $REDISCONF ]; then
    REDIS_MASTER=`cat $REDISCONF | grep replicaof | cut -d" " -f2`
fi

sed_values() {
    file=$1
    sed -i "s/__REDIS_NAME__/${REDIS_NAME}/g" $file
    sed -i "s/__REDIS_MASTER__/${REDIS_MASTER}/g" $file
    sed -i "s/__POD_FQDN__/${POD_FQDN}/g" $file
    sed -i "s/__QUORUM__/${QUORUM}/g" $file
    sed -i "s/__HEADLESS_SVC__/${HEADLESS_SVC}/g" $file
    sed -r -i "s/(sentinel monitor .*)[0-9]$/\1 ${QUORUM}/g" $file
    if [[ "$POD_FQDN" == "$REDIS_MASTER" ]]; then
        sed -i "s/__REPLICAOF__//g" $file
    else
        sed -i "s/__REPLICAOF__/replicaof ${REDIS_MASTER} 6379/g" $file
    fi

}

sed_values $confdest
chmod 766 $confdest
cat $confdest
