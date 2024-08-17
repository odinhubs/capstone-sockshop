<!-- @format -->

grafana username - admin
grafana password - admin

get default grafana password
kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

### access dashboards via nodeport

1.get the nodeport number
$ kubectl get services -n grafana

2.see the ip address of each node
$ kubectl get nodes -o wide

3.see the exact node the pod is running on
(use the NODE column to identify the exact node the pod is running and then correspond with the externalIP of the node from step2)

$ kubectl get pods -o wide

4.access directly to the node in browser
http://<node_ip>:<node_port>
