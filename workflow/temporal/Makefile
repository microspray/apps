RELEASENAME="myrelease"
REPONAME=temporal
REPOURL="https://github.com/temporalio/helm-charts/archive/refs/heads/master.zip"
NAME=temporal
NAMESPACE=temporal

CHART=temporal-chart


init: values.upstream.yaml values.yaml template  manifests/upstream/kustomization.yaml kustomization.yaml

download:
	rm -rf master.zip helm-charts-master temporal-chart
	wget $(REPOURL)
	unzip master.zip
	mv helm-charts-master temporal-chart
	rm master.zip

create-namespace:
	kubectl create namespace $(NAMESPACE)

kustomization.yaml:
	kustomize init .
	kustomize edit add resource  manifests/upstream
	kustomize edit set namespace $(NAMESPACE)

update: download dependencies

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

dependencies:
	helm repo add incubator https://charts.helm.sh/incubator
	helm repo add prometheus https://prometheus-community.github.io/helm-charts
	helm repo add elastic https://helm.elastic.co
	helm repo add grafana https://grafana.github.io/helm-charts
	helm dependency build $(CHART)

template:
	mkdir -p manifests/upstream
	helm template $(RELEASENAME) $(CHART) \
	-f values.yaml --namespace $(NAMESPACE) > manifests/upstream/$(NAME).aio.yaml
	@sed -i".bu" "s/$(RELEASENAME)-//g" manifests/upstream/$(NAME).aio.yaml
	@rm -rf manifests/upstream/*.bu
