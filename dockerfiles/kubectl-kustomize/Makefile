REG=ghcr.io
REPO=ant31/kubectl-utils

build:
	docker buildx build -f Dockerfile -t $(REG)/$(REPO):latest .
push:
	docker push $(REG)/$(REPO):latest
