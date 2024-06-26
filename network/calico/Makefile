VERSION=v3.28.0



update:
	rm -rf manifests/upstream
	mkdir -p manifests/upstream
	curl https://raw.githubusercontent.com/projectcalico/calico/$(VERSION)/manifests/tigera-operator.yaml -o manifests/upstream/tigera-operator.yaml
	curl https://raw.githubusercontent.com/projectcalico/calico/$(VERSION)/manifests/custom-resources.yaml -o manifests/upstream/custom-resources.yaml
	cd manifests/upstream && kustomize init && kustomize edit add resource "*.yaml"
