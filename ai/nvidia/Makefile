RELEASENAME="myrelease"
REPONAME=nvidia
REPOURL="https://helm.ngc.nvidia.com/nvidia"
NAME=gpu-operator
NAMESPACE=gpu-operator
CHART=$(REPONAME)/$(NAME)

all: update

create-namespace:
	kubectl create namespace $(NAMESPACE)

kustomization.yaml:
	kustomize init .
	kustomize edit add resource  manifests/upstream
	kustomize edit set namespace $(NAMESPACE)

update:
	helm repo add $(REPONAME) $(REPOURL)
	helm repo update

values.upstream.yaml:
	helm show values $(CHART) > values.upstream.yaml

values.yaml: values.upstream.yaml
	cp values.upstream.yaml values.yaml

deploy:
	kustomize build . | kubectl apply -f -

manifests/upstream/kustomization.yaml:
	mkdir -p manifests/upstream
	cd manifests/upstream && \
	kustomize init . && \
	kustomize edit add resource $(NAME).aio.yaml
	cd -

template: manifests/upstream/kustomization.yaml kustomization.yaml
	helm template \
	--kube-version=1.31 -a 'networking.k8s.io/v1/Ingress' -a monitoring.coreos.com/v1 \
	$(RELEASENAME) $(CHART) \
	 --include-crds \
	-f values.yaml --namespace $(NAMESPACE) > manifests/upstream/$(NAME).aio.yaml

	@sed -i".bu" "s/$(RELEASENAME)-//g" manifests/upstream/$(NAME).aio.yaml
	@rm -rf manifests/upstream/*.bu

