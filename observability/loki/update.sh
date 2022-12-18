#!/usr/bin/env sh

NAMESPACE="${1:-loki}"

if [ -z "$NAMESPACE" ]; then
    echo "usage: $0 [<namepace>]"
    exit 1
fi
mkdir -p manifests
(curl -fsS https://raw.githubusercontent.com/grafana/loki/master/tools/promtail.sh | sh -s _ _ _ "$NAMESPACE") > manifests/promtail.yaml
