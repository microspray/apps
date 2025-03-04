REG=quay.io
REPO=ant31/argocd-plugins
VERSION=latest
build:
	docker buildx build  --network=host  -f Dockerfile -t $(REG)/$(REPO):$(VERSION) --build-arg ARGOCD_VERSION=$(VERSION) .
push:
	docker push $(REG)/$(REPO):$(VERSION)
