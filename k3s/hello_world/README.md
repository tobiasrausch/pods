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

# Connect to kubernetes

```
export KUBECONFIG=`pwd`/../../k3s.yaml
kubectl get nodes
```

# Deploy pod

```
kubectl create deployment hwapp --image=trausch/helloworld
kubectl get deployments
kubectl describe deployments hwapp
```

# Deploy service

```
kubectl create service nodeport hwapp --tcp=5000:5000
kubectl get services
```

# Inspect the pod logs

```
kubectl get pods
export POD_NAME=$(kubectl get pods -o json | jq -r .items[0].metadata.name)
echo ${POD_NAME}
kubectl logs ${POD_NAME}
```

# Execute commands in the container

```
kubectl exec $POD_NAME -- ls
kubectl exec $POD_NAME -- pwd
kubectl exec $POD_NAME -- env
```

# Create a shell inside the container

```
kubectl exec -ti $POD_NAME -- bash
exit
```

# Use port forwarding to check working pod

```
kubectl port-forward deployment/hwapp 8000:5000 &
curl 0.0.0.0:8000
```

# Clean-up

```
kubectl delete service hwapp
kubectl delete deployment hwapp
kubectl get pods
```
