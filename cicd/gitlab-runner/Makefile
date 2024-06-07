RELEASENAME="cluster"
REPONAME=gitlab
REPOURL="https://charts.gitlab.io"
NAME=gitlab-runner
NAMESPACE=gitlab-runner

CHART=$(REPONAME)/$(NAME)

.PHONY: template update create-namespace deploy

all: kustomization.yaml
create-namespace:
	kubectl create namespace $(NAMESPACE)

kustomization.yaml: manifests/upstream/kustomization.yaml
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

manifests/upstream/kustomization.yaml: values.yaml  template
	mkdir -p manifests/upstream
	cd manifests/upstream && \
	kustomize init . && \
	kustomize edit add resource $(NAME).aio.yaml
	cd -

template:
	mkdir -p manifests/upstream
	helm template --namespace $(NAMESPACE) --kube-version=1.26 -a 'networking.k8s.io/v1/Ingress' $(RELEASENAME) $(CHART) -a monitoring.coreos.com/v1 \
	-f values.yaml > manifests/upstream/$(NAME).aio.yaml
	@sed -i".bu" "s/$(RELEASENAME)-//g" manifests/upstream/$(NAME).aio.yaml
	@rm -rf manifests/upstream/*.bu
