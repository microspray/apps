RELEASENAME="myrelease"
REPONAME=envoy-gateway
REPOURL=oci://docker.io/envoyproxy/gateway-helm

NAME=envoy-gateway
NAMESPACE="envoy-gateway-system"

CHART=$(REPOURL)


init: values.upstream.yaml values.yaml template  manifests/upstream/kustomization.yaml kustomization.yaml


create-namespace:
	kubectl create namespace $(NAMESPACE)

kustomization.yaml:
	kustomize init .
	kustomize edit add resource  manifests/upstream
	kustomize edit set namespace $(NAMESPACE)

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

template:
	mkdir -p manifests/upstream
	helm template eg $(CHART) \
	-f values.yaml --namespace $(NAMESPACE) > manifests/upstream/$(NAME).aio.yaml
	@sed -i".bu" "s/$(RELEASENAME)-//g" manifests/upstream/$(NAME).aio.yaml
	@rm -rf manifests/upstream/*.bu

	helm template eg oci://docker.io/envoyproxy/gateway-crds-helm --set crds.gatewayAPI.enabled=true \
	--set crds.gatewayAPI.channel=standard \
	--set crds.envoyGateway.enabled=true > manifests/upstream/$(NAME)-crd.aio.yaml
