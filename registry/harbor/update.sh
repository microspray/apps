#!/bin/bash

VERSION=latest
RELEASENAME="DUMMYNAME"
CHART=harbor/harbor
NAMESPACE=harbor

helm repo add harbor https://helm.goharbor.io
helm repo update
helm template $RELEASENAME $CHART -f values.yaml --namespace harbor > manifests/defaults/install.yaml
sed -i".bu" "s/$RELEASENAME-//g" manifests/defaults/install.yaml
sed -i".bu" "s/$RELEASENAME-//g" manifests/defaults/install.yaml
sed -i".bu" "s/release: $RELEASENAME/release: harbor/g" manifests/defaults/install.yaml
for x in harbor-core harbor-exporter harbor-jobservice harbor-portal  harbor-registry harbor-trivy; do
    echo $x
    sed -i".bu" "s|http://$x|http://$x.$NAMESPACE.svc.cluster.local|g" manifests/defaults/install.yaml
    sed -i".bu" "s|redis://$x|redis://$x.$NAMESPACE.svc.cluster.local|g" manifests/defaults/install.yaml
done

rm -f manifests/defaults/install.yaml.bu
