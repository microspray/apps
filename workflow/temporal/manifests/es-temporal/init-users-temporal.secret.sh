NAMESPACE=temporal
CLUSTER=es

role=temporal
user=temporal-view
user_adm=temporal-adm
password=`kubectl get secret -n $NAMESPACE    -o=jsonpath={.data.elastic} $CLUSTER-es-elastic-user | base64 -d`
echo "start a port-forward with this command:"
echo "kubectl port-forward -n $NAMESPACE svc/es-es-http 9200:9200"

curl -X POST "https://elastic:${password}@localhost:9200/_security/role/${role}-ro?pretty" -H 'Content-Type: application/json' -k -d'
{
  "cluster": ["all"],
  "indices": [
    {
      "names": [ "temporal-*"],
      "privileges": ["read"]
    }
  ]
}
'

curl -X POST "https://elastic:${password}@localhost:9200/_security/user/${user}?pretty" -H 'Content-Type: application/json' -k -d"
{
  \"password\" : \"fdasf9u7fsfh7!!!CHANGEME\",
  \"roles\" : [ \"${role}-ro\" ],
  \"full_name\" : \"temporal Reader\",
  \"email\" : \"al@microspray.io\"
}
"

# WRITER
curl -X POST "https://elastic:${password}@localhost:9200/_security/role/${role}-rw?pretty" -H 'Content-Type: application/json' -k -d'
{
  "cluster": ["all"],
  "indices": [
    {
      "names": [ "temporal-*"],
      "privileges": ["all"]
    }
  ]
}
'

curl -X POST "https://elastic:${password}@localhost:9200/_security/user/${user_adm}?pretty" -H 'Content-Type: application/json' -k -d"
{
  \"password\" : \"Au3!!!CHANGEME\",
  \"roles\" : [ \"${role}-rw\" ],
  \"full_name\" : \"Temporal index admin\",
  \"email\" : \"al-adm@microspray.io\"
}
"
