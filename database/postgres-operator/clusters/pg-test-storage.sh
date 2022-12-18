#!/bin/bash

a=microsdev-alegrand-hdd0
an=ceph-no-replica
b=microsdev-alegrand-hdd
bn=localhdd
c=microsdev-alegrand-ssd
cn=localssd
d=microsdev-alegrand
db=ceph-2-replica
KUBECONFIG=$1
function pgtest () {
    NAMESPACE=pg-test
    CLUSTER=$1
    PASSWORD=`kubectl get secret postgres.$CLUSTER.credentials.postgresql.acid.zalan.do -n $NAMESPACE -o 'jsonpath={.data.password}' | base64 -d`
    PGUSER=`kubectl get secret postgres.$CLUSTER.credentials.postgresql.acid.zalan.do -n $NAMESPACE -o 'jsonpath={.data.username}' | base64 -d`
    HOSTIP=`kubectl get svc -n $NAMESPACE $CLUSTER -o jsonpath="{.spec.clusterIP}"`
    echo "HOST":    $HOSTIP
    echo "USERNAME: $PGUSER"
    echo "PASSWORD: $PASSWORD"
    echo "export PGSSLMODE=require"
    echo "export PGHOST=$HOSTIP"
    echo "export PGUSER=$PGUSER"
    echo "export PGPASSWORD=$PASSWORD"
    pgbench -t 100 -c 10 -j 5 -v
}

pgtest $a
pgtest $b
pgtest $d
pgtest $c
