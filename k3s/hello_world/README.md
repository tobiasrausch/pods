# Build docker image

`docker build -t helloworld .`

# Trial run

```
docker run -d -p 8000:5000 --name hwapp helloworld
sleep 10
curl 0.0.0.0:8000
docker stop hwapp
docker rm hwapp
```

# Push to docker hub

```
docker tag helloworld trausch/helloworld
docker push trausch/helloworld
```

# Deploy pod, forward port via service and curl ip:port

```
export KUBECONFIG=`pwd`/../../k3s.yaml
kubectl get nodes
kubectl create deployment hwapp --image=trausch/helloworld
kubectl get deployments
kubectl describe deployments hwapp
kubectl expose deployments/hwapp --type="NodePort" --port 5000
kubectl get services
export NODE_PORT=$(kubectl get services/hwapp -o json | jq ".spec.ports[0].nodePort")
IP=$(multipass info master | grep IPv4 | awk '{print $2}')
curl ${IP}:${NODE_PORT}
kubectl get pods
export POD_NAME=$(kubectl get pods -o json | jq -r .items[0].metadata.name)
kubectl logs ${POD_NAME}
```

# Execute commands in the container, enter shell

```
kubectl exec $POD_NAME -- ls
kubectl exec $POD_NAME -- pwd
kubectl exec $POD_NAME -- env
kubectl exec -ti $POD_NAME -- bash
exit
```

# Clean-up

```
kubectl delete service hwapp
kubectl delete deployments,replicasets,pods --all
kubectl get pods,deployments,services
```
