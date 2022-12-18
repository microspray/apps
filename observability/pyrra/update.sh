#!/usr/bin/env sh

mkdir -p manifests/upstream
(cd manifests/upstream && curl -fsSO https://raw.githubusercontent.com/pyrra-dev/pyrra/main/config/crd/bases/pyrra.dev_servicelevelobjectives.yaml)
(cd manifests/upstream && curl -fsSO https://raw.githubusercontent.com/pyrra-dev/pyrra/main/config/rbac/role.yaml)
(cd manifests/upstream && curl -fsSO https://raw.githubusercontent.com/pyrra-dev/pyrra/main/config/api.yaml)
(cd manifests/upstream && curl -fsSO https://raw.githubusercontent.com/pyrra-dev/pyrra/main/config/kubernetes.yaml)
