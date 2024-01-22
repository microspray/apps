RELEASENAME="redis"
VERSION=18.7.1
REPONAME=redis
REPOURL="oci://registry-1.docker.io/bitnamicharts/redis"

NAME=redis
NAMESPACE=redis
CHART=bitnamicharts-redis


init: values.upstream.yaml values.yaml template  manifests/upstream/kustomization.yaml kustomization.yaml


create-namespace:
	kubectl create namespace $(NAMESPACE)

kustomization.yaml:
	kustomize init .
	kustomize edit add resource  manifests/upstream
	kustomize edit set namespace $(NAMESPACE)

update: pull

values.upstream.yaml: update
	helm show values $(CHART)/$(NAME) > values.upstream.yaml

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

pull:
	rm -rf  $(CHART)
	helm pull $(REPOURL) --version $(VERSION) --untar --untardir  $(CHART)

template:
	mkdir -p manifests/upstream
	helm template $(RELEASENAME) $(CHART)/$(NAME) \
    --kube-version=1.25 -a 'networking.k8s.io/v1/Ingress' -a monitoring.coreos.com/v1 \
	-f values.yaml --namespace $(NAMESPACE) > manifests/upstream/$(NAME).aio.yaml
	@sed -i".bu" "s/$(RELEASENAME)-//g" manifests/upstream/$(NAME).aio.yaml
	@rm -rf manifests/upstream/*.bu
