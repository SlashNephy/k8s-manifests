# k8s-manifests

## Setup

- [1Password Connect Server & Operator](https://github.com/1Password/connect-helm-charts/tree/main/charts/connect)

```console
$ helm repo add 1password https://1password.github.io/connect-helm-charts
$ helm install connect \
    1password/connect \
    --set-file connect.credentials=1password-credentials.json \
    --set operator.create=true \
    --set operator.token.value=$OP_CONNECT_TOKEN \
    --set operator.autoRestart=true \
    -n 1password \
    --create-namespace
```

- [cert-manager](https://cert-manager.io/docs/installation/helm/)

```console
$ helm repo add jetstack https://charts.jetstack.io
$ helm install \
    cert-manager jetstack/cert-manager \
    --set installCRDs=true \
    -n traefik \
    --create-namespace
```

## Commands

- port-forward `kubernetes-dashboard`

```console
$ kubectl port-forward src/kubernetes-dashboard 8081:443 \
    -n kubernetes-dashboard \
    --address=0.0.0.0
```

- port-forward `argo-cd`

```console
$ kubectl port-forward svc/argo-cd-argocd-server 8082:443 \
    -n argo-cd \
    --address=0.0.0.0
```

- Generate bearer token for kubernetes-dashboard

```console
$ kubectl create token admin-user -n kubernetes-dashboard --duration=4294967296s
```

- Check Argo CD initial password

```console
$ kubectl get secret argocd-initial-admin-secret \
    -n argo-cd \
    -o jsonpath="{.data.password}" | base64 -d; echo
```
