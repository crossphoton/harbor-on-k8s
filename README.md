# do-challenge
Digitalocean k8s challenge

```
Deploy an internal container registry.
```

This repo works towards deploying [**harbor**](https://goharbor.io/) for the same purpose.

## **Installation**

> Note: SSL not configured. I used cloudflare to replace manual SSL configuration.

## Quick Installation

> Use the script [deploy.sh](./deploy.sh).

## Step-by-Step

### Requirements
1. Helm
2. Kubectl
3. `kubeconf.yml` setted up

### Steps

1. Add ***nginx-ingress:***
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.0/deploy/static/provider/do/deploy.yaml
```

2. Add the ***harbor repo***
```
helm repo add harbor https://helm.goharbor.io
```

3. Deploy the ***harbor chart*** in the cluster using:

```
helm install harbor harbor/harbor --values values/harbor.yml -n harbor --create-namespace
```
> Change the domain in [values file](./values/harbor.yml) as per the need.

4. Patch the default ***harbor-ingress*** to work with nginx - `Just add the nginx ingress class`
```
kubectl patch ingress/harbor-ingress -p \
'{"spec": {"ingressClassName": "nginx"}}' -n harbor
```

## Hosted link
- [Harbor](https://harbor.crossphoton.tech)

## License
MIT License

## Places I faced difficulties

- **Configuring ingress** - I was directly exposing the service which somehow didn't work. Eventually ended up setting up nginx-ingress.

## Appreciation
- The interface of DO is very very clean.
- To the amazing softwares which I got introduced to.
- To DO for the opportunity
- To the below mentioned tools and resources
    - Helm
    - Harbor
    - K8s Docs
