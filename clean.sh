helm uninstall -n harbor harbor
kubectl delete namespaces/harbor
kubectl delete -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.0/deploy/static/provider/do/deploy.yaml
