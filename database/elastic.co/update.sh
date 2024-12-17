#!/bin/bash
VERSION=2.15.0
rm -rf manifests/upstream
mkdir -p manifests/upstream
curl -L https://download.elastic.co/downloads/eck/$VERSION/crds.yaml > manifests/upstream/crds.yaml
curl -L https://download.elastic.co/downloads/eck/$VERSION/operator.yaml > manifests/upstream/install.yaml

cd manifests/upstream
kustomize init
kustomize edit add resource crds.yaml
kustomize edit add resource install.yaml

cd ../..
