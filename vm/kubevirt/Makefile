RELEASE=v1.4.0

update:
	rm -rf manifests/upstream
	mkdir -p manifests/upstream
	echo https://github.com/kubevirt/kubevirt/releases/download/${RELEASE}/kubevirt-operator.yaml
	curl -L https://github.com/kubevirt/kubevirt/releases/download/${RELEASE}/kubevirt-operator.yaml -o manifests/upstream/kubevirt-operator.yaml
	curl -L https://github.com/kubevirt/kubevirt/releases/download/${RELEASE}/kubevirt-cr.yaml -o manifests/upstream/kubevirt-cr.yaml
	cd manifests/upstream && kustomize init && kustomize edit add resource "*.yaml"

wait:
	kubectl -n kubevirt wait kv kubevirt --for condition=Available
