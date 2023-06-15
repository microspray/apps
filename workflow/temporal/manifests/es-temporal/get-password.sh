NAMESPACE=temporal
CLUSTER=es

kubectl get secret -n $NAMESPACE    -o=jsonpath={.data.elastic} $CLUSTER-es-elastic-user | base64 -d
