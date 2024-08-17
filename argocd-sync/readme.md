# ARGOCD 
ArgoCD is a declarative, GitOps continuous delivery tool for Kubernetes. It enables developers to manage and deploy applications on Kubernetes clusters using Git repositories as the source of truth for defining the desired application state. argocd (https://argo-cd.readthedocs.io/en/stable/getting_started/)


### ACCESSING ARGOCD DASHBOARD
The argocd-server had a cluster ip so the service type was changed to a loadbalancer. This was done by:
- running the command `kubectl get all -n argocd`
- editing argocd server: `kubectl edit svc argocd-server -n argocd`
- changing the type to **LoadBalancer or NodePort**
- running `kubectl get svc -n argocd`

To get the password for the argocd run:
`kubectl get secret -n argocd`
This will output
```
NAME                          TYPE     DATA   AGE
argocd-initial-admin-secret   Opaque   1      56m
argocd-notifications-secret   Opaque   0      56m
argocd-secret                 Opaque   5      56m

```
To get the initial admin secret run:
`kubectl get secret argocd-initial-admin-secret -o yaml -n argocd`. This will output the information in a yaml format
NOTE: You can also decide to get the output in a json format.

```
apiVersion: v1
data:
  password: YUR2clRHQkQwQUd6a0lyZQ==
kind: Secret
metadata:
  creationTimestamp: "2024-03-06T11:06:21Z"
  name: argocd-initial-admin-secret
  namespace: argocd
  resourceVersion: "1584"
  uid: 36f81d61-9db6-406b-95b0-ee16deb61236
type: Opaque

```
To decrypt the password run:
`echo "YUR2clRHQkQwQUd6a0lyZQ==" | openssl base64 -d ; echo`
Password = aDvrTGBD0AGzkIre


## ARGOCD-SLACK ALERTS
The alerts were configured using slack as the notification method. To enable this you need to:
- Open a Slack Account and create a workspace. 
- Confirm the deployment of ArgoCD notification pods by running the command

      `kubectl get cm argocd-notifications-cm -n <argocd-namespace> -o yaml`
- Configure secrets and tokens in the argocd config map by:
    ```
      kubectl patch secret argocd-notifications-secret -n <argocd-namespace> \
       --type merge --patch '{"stringData":{"slack-token": "<your-slack-token>"}}'

    ```
- Check if it has been added by running 

      `kubectl get secret argocd-notifications-secret -n <argocd-namespace> -o yaml`
- Configure Slack integration in the argocd-notifications-cm ConfigMap by running the command 

       `kubectl patch configmap argocd-notifications-cm -n <argocd-namespace> --type merge -p '{"data": {"service.slack": "token: $slack-token"}}'`


## INSTALL ARGOCD CLI
- Go to (https://github.com/argoproj/argo-cd/releases) which is the link you copied the link to install argocd.
- scroll down to assets
- copy the link address of the cli option you want. For this project I used (https://github.com/argoproj/argo-cd/releases/download/v2.9.7/argocd-linux-amd64)
- run `wget https://github.com/argoproj/argo-cd/releases/download/v2.9.7/argocd-linux-amd64` on your terminal
- make the file executable `sudo chmod +x argocd-linux-amd64`
- move the file to the `/usr/local/bin` directory
- run: argocd (the man pages of argocd will be outputted)

**To Login on to argocd on your terminal run:**
- `argocd login <ip of the argocd-server>`
- input the username and password.

