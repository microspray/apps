#!/bin/bash
REPO=postgres-operator
GITHUB_ORG=zalando
VERSION=1.13.0
V=v
rm -rf manifests/defaults/operator
rm -rf manifests/defaults/ui
curl -L https://github.com/$GITHUB_ORG/$REPO/archive/$V$VERSION.zip > $REPO.zip
unzip -o $REPO.zip
cp -r $REPO-$VERSION/manifests/ manifests/defaults/operator
cp -r $REPO-$VERSION/ui/manifests/ manifests/defaults/ui
rm -rf $REPO.zip $REPO-$VERSION
cd manifests/defaults
# kustomize edit add resource manifests/*.yaml
# kustomize edit add resource manifests/ui/*.yaml
cd ../..
