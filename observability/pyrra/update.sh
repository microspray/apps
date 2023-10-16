#!/usr/bin/env sh

rm -rf manifests/upstream
mkdir -p manifests/upstream
(cd manifests/upstream && curl -fsSO https://raw.githubusercontent.com/pyrra-dev/pyrra/main/examples/kubernetes/manifests-webhook/setup/pyrra-slo-CustomResourceDefinition.yaml)
(cd manifests/upstream && head -c -1 <<EOF | parallel -I {} curl -fsSO https://raw.githubusercontent.com/pyrra-dev/pyrra/main/examples/kubernetes/manifests-webhook/pyrra-{}.yaml
apiDeployment
apiService
apiServiceAccount
apiServiceMonitor
certificate
issuer
kubernetesClusterRole
kubernetesClusterRoleBinding
kubernetesDeployment
kubernetesService
kubernetesServiceAccount
kubernetesServiceMonitor
webhook
EOF
)
