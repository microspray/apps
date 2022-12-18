#!/bin/bash
CLUSTER=$2
NAMESPACE=$1
PASSWORD=`kubectl get secret postgres.$CLUSTER.pg.creds -n $NAMESPACE -o 'jsonpath={.data.password}' | base64 -d`
PGUSER=`kubectl get secret postgres.$CLUSTER.pg.creds -n $NAMESPACE -o 'jsonpath={.data.username}' | base64 -d`
HOSTIP=`kubectl get svc -n $NAMESPACE $CLUSTER -o jsonpath="{.spec.clusterIP}"`



echo "HOST":    $HOSTIP
echo "USERNAME: $PGUSER"
echo "PASSWORD: $PASSWORD"

echo "export PGSSLMODE=require"
echo "export PGHOST=$HOSTIP"
echo "export PGUSER=$PGUSER"
echo "export PGPASSWORD=$PASSWORD"
