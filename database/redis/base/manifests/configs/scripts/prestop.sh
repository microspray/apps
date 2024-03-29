#!/usr/bin/env bash
REDIS_NAME=${REDIS_NAME:-"myMaster"}
REDIS_PORT=${REDIS_PORT:-"6379"}
REDIS_HOST=${REDIS_HOST:-"0.0.0.0"}
REDIS_SENTINEL_HOST=${REDIS_SENTINEL_HOST:-"0.0.0.0"}
REDIS_SENTINEL_PORT=${REDIS_SENTINEL_PORT:-"26379"}
REDIS_MODE=${REDIS_MODE:-"server"}
REDIS_USER=${REDIS_USER:-"default"}
REDIS_PASSWORD=${REDIS_PASSWORD:-"default"}
uri="redis://$REDIS_USER:$REDIS_PASSWORD@$REDIS_SENTINEL_HOST:$REDIS_SENTINEL_PORT"
urilocal="redis://$REDIS_USER:$REDIS_PASSWORD@$REDIS_HOST:$REDIS_PORT"
get_redis_role() {
  is_master=$(
    redis-cli \
      -u $urilocal \
      info | grep -c 'role:master' || true
  )
}

get_redis_role
if [[ "$is_master" -eq 1 ]]; then
  if [[ "$REDIS_MODE" == "sentinel" ]]; then
    echo "We are in sentinel mode, we're waiting for the failover to happen."
  else
    echo "This node is currently master, we trigger a failover."
  response=$(
    redis-cli \
      -u $uri \
      SENTINEL failover $REDIS_NAME
  )
  fi
  if [[ "$response" != "OK" ]] ; then
    echo "$response"
    exit 1
  fi
  timeout=30
  while [[ "$is_master" -eq 1 && $timeout -gt 0 ]]; do
    sleep 1
    get_redis_role
    timeout=$((timeout - 1))
  done
  echo "Failover successful"
else
    echo "This node is currently slave, we do nothing."
fi
