RELEASENAME="myrelease"
REPONAME=cilium
REPOURL="https://helm.cilium.io/"
NAME=cilium
NAMESPACE=kube-network

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

template: manifests/upstream/kustomization.yaml kustomization.yaml preflight
	helm template \
	--kube-version=1.32 -a 'networking.k8s.io/v1/Ingress' -a monitoring.coreos.com/v1 \
	$(RELEASENAME) $(CHART) \
	-f values.yaml --namespace $(NAMESPACE) > manifests/upstream/$(NAME).aio.yaml

	@sed -i".bu" "s/$(RELEASENAME)-//g" manifests/upstream/$(NAME).aio.yaml
	@rm -rf manifests/upstream/*.bu

preflight: manifests/upstream/kustomization.yaml kustomization.yaml
	helm template \
	--set preflight.enabled=true \
	--set agent=false \
	--set operator.enabled=false \
	--kube-version=1.35 -a 'networking.k8s.io/v1/Ingress' -a monitoring.coreos.com/v1 \
	$(RELEASENAME) $(CHART) \
	-f values.yaml --namespace $(NAMESPACE) > manifests/upstream/$(NAME).preflight.yaml

	@sed -i".bu" "s/$(RELEASENAME)-//g" manifests/upstream/$(NAME).preflight.yaml
	@rm -rf manifests/upstream/*.bu
