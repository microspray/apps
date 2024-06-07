#!/bin/bash

VERSION=latest
"${RELEASENAME:=DUMMYNAME}"
CHART=gitlab/gitlab-runner
NAMESPACE=gitlab-runner
helm repo add gitlab https://charts.gitlab.io
helm repo update
helm template $RELEASENAME $CHART -f values.yaml --namespace $NAMESPACE > manifests/defaults/install.yaml
sed -i".bu" "s/$RELEASENAME-//g" manifests/defaults/install.yaml
sed -i".bu" "s/release: $RELEASENAME/release: gitlab-runner/g" manifests/defaults/install.yaml

rm -f manifests/defaults/install.yaml.bu
