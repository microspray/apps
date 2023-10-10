#!/usr/bin/env sh

rm -rf manifests/upstream
mkdir -p manifests/upstream
(cd manifests/upstream && curl -fsSO https://raw.githubusercontent.com/pyrra-dev/pyrra/main/examples/kubernetes/manifests-webhook/setup/pyrra-slo-CustomResourceDefinition.yaml)
(cd manifests/upstream && printf "apiDeployment\napiService\napiServiceAccount\napiServiceMonitor\ncertificate\nissuer\nkubernetesClusterRole\nkubernetesClusterRoleBinding\nkubernetesDeployment\nkubernetesService\nkubernetesServiceAccount\nkubernetesServiceMonitor\nwebhook" | xargs -I {} curl -fsSO https://raw.githubusercontent.com/pyrra-dev/pyrra/main/examples/kubernetes/manifests-webhook/pyrra-{}.yaml)
