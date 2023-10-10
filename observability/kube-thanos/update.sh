#!/usr/bin/env sh

curl -L https://codeload.github.com/thanos-io/kube-thanos/zip/refs/heads/main -o kube-thanos.zip
curl -L https://codeload.github.com/observatorium/observatorium/zip/refs/heads/main -o observatorium.zip
unzip -o kube-thanos.zip
unzip -o observatorium.zip
rm -rf manifests/upstream
mkdir -p manifests/upstream/manifests
cp $(find kube-thanos-main/examples/all/manifests -type f | grep -v -e bucket -e receive -e rule -e shard) manifests/upstream/manifests
cp $(find observatorium-main/configuration/examples/local/manifests/observatorium -type f | grep cache) manifests/upstream/manifests
rm -rf kube-thanos.zip kube-thanos-main
rm -rf observatorium.zip observatorium-main
grep observatorium manifests/upstream/manifests/* -l | parallel sed -i '/instance:\ observatorium-xyz/d'
grep observatorium manifests/upstream/manifests/* -l | parallel sed -i 's/observatorium-xyz-//'
grep observatorium manifests/upstream/manifests/* -l | parallel sed -i 's/observatorium/thanos/'
sed -i 's/<MEMCACHED_SERVICE>/thanos-store-memcached/g' manifests/upstream/manifests/thanos-store-statefulSet.yaml
sed -i 's/<MEMCACHED_SERVICE>/thanos-query-frontend-memcached/g' manifests/upstream/manifests/thanos-query-frontend-deployment.yaml
(cd manifests/upstream && kustomize init . && kustomize edit add resource manifests/*.yaml)
