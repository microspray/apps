#!/usr/bin/env bash
REDIS_NAME=${REDIS_NAME:-"myMaster"}
REDIS_MASTER=${REDIS_INITIAL_MASTER_HOST:-"localost"}
REDIS_PASSWORD=${REDIS_PASSWORD:-"default"}
QUORUM=${QUORUM:-"2"}
DOWN_AFTER=${DOWN_AFTER:-"5000"}
POD_FQDN=${POD_FQDN:-"localhost"}
sed_values() {
    file=$1
    sed -i "s/__REDIS_NAME__/${REDIS_NAME}/g" $file
    sed -i "s/__REDIS_MASTER__/${REDIS_MASTER}/g" $file
    sed -i "s/__REDIS_PASSWORD__/${REDIS_PASSWORD}/g" $file
    sed -i "s/__POD_FQDN__/${POD_FQDN}/g" $file
    sed -i "s/__QUORUM__/${QUORUM}/g" $file
    sed -i "s/__DOWN_AFTER__/${DOWN_AFTER}/g" $file
    sed -i "s/__HEADLESS_SVC__/${HEADLESS_SVC}/g" $file
    sed -r -i "s/(sentinel monitor .*)[0-9]$/\1 ${QUORUM}/g" $file
    if [[ "$POD_FQDN" == "$REDIS_MASTER" ]] ; then
        sed -i "s/__REPLICAOF__//g" $file
    else
        sed -i "s/__REPLICAOF__/replicaof ${REDIS_MASTER} 6379/g" $file
    fi

}

dir=$1
for file in `find $dir -type f -name "*.conf"`; do
    sed_values $file
done
