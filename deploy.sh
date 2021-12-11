if hash helm > /dev/null; then
    echo "Found installation of helm..."
else
    echo "Helm not found"
    read -e -p "Proceed with helm installation?[Y/N] " yn
    if [[ "y" = "$yn" || "Y" = "$yn" ]]; then
        echo "Installing helm......"
        curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
        chmod 700 get_helm.sh
        ./get_helm.sh
    else
        echo "Helm is required but not found. Exiting....."
        exit 1
    fi
fi


echo
echo "Adding nginx ingress..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.0/deploy/static/provider/do/deploy.yaml


echo
echo "Deploying Harbour in cluster..."
helm show values harbor/harbor > /dev/null || helm repo add harbor https://helm.goharbor.io
helm install harbor harbor/harbor --values values/harbor.yml -n harbor --create-namespace

kubectl patch ingress/harbor-ingress -p \
'{"spec": {"ingressClassName": "nginx"}}' -n harbor
