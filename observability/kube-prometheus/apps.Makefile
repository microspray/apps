all: gen

gen-output:
	mkdir -p gen-output

.PHONY: gen
gen: clean gen-output
	kubectl kustomize . | kubectl slice -o gen-output --skip-non-k8s --template "{{.metadata.name}}.{{.metadata.namespace}}.{{.kind | lower}}.yaml"
	cd gen-output && kustomize init && kustomize edit add resource "*.yaml"

.PHONY: clean
clean:
	rm -rf gen-output
