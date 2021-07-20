# Usual kubectl configuration

```
export KUBECONFIG=`pwd`/../../k3s.yaml
kubectl get nodes
IP=$(multipass info master | grep IPv4 | awk '{print $2}')
echo ${IP}
multipass list
```

# Create a persistent volume claim (pvc) using local storage on the virtual ubuntu instance

```
kubectl get pvc
kubectl apply -f pvc.yaml 
kubectl get pvc
```

# Create a pod using the storage

```
kubectl apply -f pod.yaml
sleep 10
kubectl get pvc
kubectl get pv
```

# Write something, delete the pod, re-create pod and check file content

```
kubectl get pods
kubectl exec volume-test -- sh -c "echo local-path-test > /data/test"
kubectl exec volume-test -- sh -c "cat /data/test"
kubectl delete -f pod.yaml
sleep 10
kubectl get pods
kubectl apply -f pod.yaml
sleep 10
kubectl exec volume-test -- sh -c "cat /data/test"
kubectl delete -f pod.yaml
```

# Check the host path if file content is still there (only on one node)

```
multipass list
ssh -i ~/.ssh/multipass ubuntu@<ip_address_of_node>
ls /var/lib/rancher/k3s/storage
exit
```

# Delete pvc

```
kubectl get pvc
kubectl delete -f pvc.yaml 
kubectl get pv,pvc
ssh -i ~/.ssh/multipass ubuntu@<ip_address_of_node>
ls /var/lib/rancher/k3s/storage
exit
```

