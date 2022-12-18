#!/bin/bash

kname=$1
kgroup=$2
kpath=$3
filename=$kname.$2.argocd.yaml
dir=${kgroup}_${kname}
dest=$dir/$filename
mkdir -p $dir
cp _template.yaml $dest
sed -i "s:_PATH_:$kpath:g" $dest
sed -i "s:_NAME_:$kname:g" $dest
cd $dir
kustomize init .
kustomize edit add resource $filename
cd ..

