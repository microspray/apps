# syntax=docker/dockerfile:1.4
ARG ARGOCD_VERSION=v2.14.3
FROM quay.io/ant31/kubectl-utils:latest AS download
RUN echo hello


FROM quay.io/argoproj/argocd:${ARGOCD_VERSION}

# Switch to root for the ability to perform install
USER root

# Install tools needed for your repo-server to retrieve & decrypt secrets, render manifests
# (e.g. curl, awscli, gpg, sops)

RUN apt-get update && \
    apt-get install -y \
    curl \
    git-crypt\
    gettext \
    gpg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*




COPY --from=download /usr/local/bin/kubectl /usr/local/bin/kubectl
COPY --from=download /usr/local/bin/kustomize /usr/local/bin/kustomize
COPY --from=download /usr/bin/git-crypt	 /usr/local/bin/git-crypt
COPY --from=download /usr/local/bin/kubectl-hns /usr/local/bin/kubectl-hns
COPY --from=download /usr/local/bin/gh /usr/local/bin/gh
COPY --from=download /usr/local/bin/kubeconform /usr/local/bin/kubeconform
COPY --from=download /usr/local/bin/kubectl-krew /usr/local/bin/kubectl-krew
COPY --from=download /usr/local/bin/helm /usr/local/bin/helm
RUN kubectl-krew install krew
RUN kubectl-krew install slice
ENV KREW_ROOT=/root/.krew
ENV PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Switch back to non-root user
USER 1000
