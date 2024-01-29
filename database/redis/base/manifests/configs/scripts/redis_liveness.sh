#!/bin/bash
REDIS_USER=${REDIS_USER:-"default"}
REDIS_PASSWORD=${REDIS_PASSWORD:-"default"}
REDIS_PORT=${REDIS_PORT:-"6379"}
REDIS_HOST=${REDIS_HOST:-"0.0.0.0"}
uri="redis://$REDIS_USER:$REDIS_PASSWORD@$REDIS_HOST:$REDIS_PORT"

response=$(
  redis-cli \
    -u $uri \
    ping
)
if [ "$response" != "PONG" ] && [ "${response:0:7}" != "LOADING" ] ; then
  echo "$response"
  exit 1
fi
echo "response=$response"
