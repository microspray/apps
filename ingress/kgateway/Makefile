RELEASENAME="myrelease"
REPONAME=rook-release
REPOURL="https://charts.rook.io/release"

NAME=rook-ceph-cluster
NAMESPACE=rook-ceph

CHART=$(REPONAME)/$(NAME)


init: values.upstream.yaml values.yaml template  manifests/upstream/kustomization.yaml kustomization.yaml


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

template:
	mkdir -p manifests/upstream
	helm template $(RELEASENAME) $(CHART) \
    --kube-version=1.31 -a 'networking.k8s.io/v1/Ingress' -a monitoring.coreos.com/v1 \
	-f values.yaml --namespace $(NAMESPACE) > manifests/upstream/$(NAME).aio.yaml
	@sed -i".bu" "s/$(RELEASENAME)-//g" manifests/upstream/$(NAME).aio.yaml
	@rm -rf manifests/upstream/*.bu
