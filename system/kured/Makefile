VERSION=1.13.2
NAME=kured
NAMESPACE=kured
REPOURL=https://github.com/kubereboot/kured/releases/download/$(VERSION)/kured-$(VERSION)-dockerhub.yaml

all: init

init: update manifests/upstream/kustomization.yaml kustomization.yaml


create-namespace:
	kubectl create namespace $(NAMESPACE)

kustomization.yaml:
	kustomize init .
	kustomize edit add resource  manifests/upstream
	kustomize edit set namespace $(NAMESPACE)

update:
	mkdir -p manifests/upstream
	curl -L $(REPOURL) > manifests/upstream/kured.aio.yaml

deploy:
	kustomize build . | kubectl apply -f -

manifests/upstream/kustomization.yaml:
	mkdir -p manifests/upstream
	cd manifests/upstream && \
	kustomize init . && \
	kustomize edit add resource $(NAME).aio.yaml
	cd -
