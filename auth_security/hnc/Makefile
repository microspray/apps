# Select the latest version of HNC
HNC_VERSION=v1.0.0
NAMESPACE="hnc-system"
# Install HNC. Afterwards, wait up to 30s for HNC to refresh the certificates on its webhooks.
NAME=hnc

init: template  manifests/upstream/kustomization.yaml kustomization.yaml


create-namespace:
	kubectl create namespace $(NAMESPACE)

kustomization.yaml:
	kustomize init .
	kustomize edit add resource  manifests/upstream
	kustomize edit set namespace $(NAMESPACE)

deploy:
	kustomize build . | kubectl apply -f -

manifests/upstream/kustomization.yaml:
	mkdir -p manifests/upstream
	cd manifests/upstream && \
	kustomize init . && \
	kustomize edit add resource $(NAME).aio.yaml
	cd -

template:
	mkdir -p manifests/upstream
	curl -L https://github.com/kubernetes-sigs/hierarchical-namespaces/releases/download/${HNC_VERSION}/default.yaml \
	> manifests/upstream/$(NAME).aio.yaml
