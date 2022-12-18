NAME=pgadmin
NAMESPACE=pgadmin


create-namespace:
	kubectl create namespace $(NAMESPACE)

deploy:
	kustomize build . | kubectl apply -f -
