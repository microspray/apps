#!/bin/bash
rm -rf manifests/upstream/manifests
curl -L https://codeload.github.com/prometheus-operator/kube-prometheus/zip/refs/heads/main > kube-prometheus.zip
unzip -o  kube-prometheus.zip
rm -rf manifests/upstream
mkdir -p manifests/upstream
cp -r kube-prometheus-main/manifests/ manifests/upstream/
rm -rf kube-prometheus.zip kube-prometheus-main
cd manifests/upstream
kustomize init .
kustomize edit add resource manifests/setup/*.yaml
kustomize edit add resource manifests/*.yaml
cd ../..
