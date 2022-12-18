VERSION=v1.2.0


if [[ "$OSTYPE" == "darwin"* ]]; then
    TARBALL=kubectl-cert_manager-darwin-amd64.tar.gz
else
    TARBALL=kubectl-cert_manager-linux-amd64.tar.gz
fi

curl -L -o kubectl-cert-manager.tar.gz https://github.com/jetstack/cert-manager/releases/download/$VERSION/$TARBALL

tar xzf kubectl-cert-manager.tar.gz
sudo mv kubectl-cert_manager /usr/local/bin
rm LICENSES kubectl-cert-manager.tar.gz
