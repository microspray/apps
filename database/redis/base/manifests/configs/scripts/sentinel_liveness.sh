#!/bin/bash

REDIS_SENTINEL_HOST=${REDIS_SENTINEL_HOST:-"0.0.0.0"}
REDIS_SENTINEL_PORT=${REDIS_SENTINEL_PORT:-"26379"}
REDIS_USER=${REDIS_USER:-"default"}
REDIS_PASSWORD=${REDIS_PASSWORD:-"default"}
uri="redis://$REDIS_USER:$REDIS_PASSWORD@$REDIS_SENTINEL_HOST:$REDIS_SENTINEL_PORT"

response=$(
  redis-cli \
    -u $uri \
    ping
)
if [ "$response" != "PONG" ]; then
  echo "$response"
  exit 1
fi
echo "response=$response"
