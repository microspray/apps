# Downloader
FROM alpine:3 AS download
RUN apk add --update-cache \
    bash \
    git-crypt \
    build-base \
    curl \
    tar

WORKDIR /downloads

RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
RUN chmod +x kubectl

RUN curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
RUN chmod +x kustomize

RUN curl -L https://github.com/kubernetes-sigs/multi-tenancy/releases/download/hnc-v1.1.0/kubectl-hns_linux_amd64 -o ./kubectl-hns
RUN chmod +x ./kubectl-hns

RUN curl -L -o gh.tar.gz https://github.com/cli/cli/releases/download/v2.67.0/gh_2.67.0_linux_amd64.tar.gz
RUN tar xvf gh.tar.gz && mv gh_2.67.0_linux_amd64/bin/gh . && chmod +x gh

RUN curl -L -o kubeconform.tar.gz https://github.com/yannh/kubeconform/releases/download/v0.6.7/kubeconform-linux-amd64.tar.gz
RUN tar xvf kubeconform.tar.gz && chmod +x kubeconform

RUN curl -L "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew-linux_amd64.tar.gz" -o krew.tar.gz
RUN tar xvf "krew.tar.gz" && mv krew-linux_amd64 krew && chmod +x krew

run curl -L https://get.helm.sh/helm-v3.17.1-linux-amd64.tar.gz -o helm.tar.gz
run tar xvf helm.tar.gz && mv linux-amd64/helm helm && chmod +x helm

FROM python:alpine

RUN apk add --no-cache git-crypt make gettext bash git libc6-compat


COPY --from=download /downloads/kubectl /usr/local/bin/kubectl
COPY --from=download /downloads/kustomize /usr/local/bin/kustomize
COPY --from=download /usr/bin/git-crypt	 /usr/local/bin/git-crypt
COPY --from=download /downloads/kubectl-hns /usr/local/bin/kubectl-hns
COPY --from=download /downloads/gh /usr/local/bin/gh
COPY --from=download /downloads/kubeconform /usr/local/bin/kubeconform
COPY --from=download /downloads/krew /usr/local/bin/kubectl-krew
COPY --from=download /downloads/helm /usr/local/bin/helm
RUN kubectl-krew install krew
RUN kubectl-krew install slice
ENV KREW_ROOT=/root/.krew
ENV PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
