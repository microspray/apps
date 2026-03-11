#!/bin/bash
VERSION=v2.5.5

curl -L  https://raw.githubusercontent.com/argoproj/argo-cd/$VERSION/manifests/ha/install.yaml > manifests/defaults/install.yaml

if [[ "$OSTYPE" == "darwin"* ]]; then
    ARCH=darwin
else
    ARCH=linux
fi
ARGOBIN=$HOME/.local/bin/argocd
curl -sSL -o $ARGOBIN https://github.com/argoproj/argo-cd/releases/download/$VERSION/argocd-$ARCH-amd64

chmod +x $ARGOBIN
