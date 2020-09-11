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
docker tag helloworld trausch/helloworld
docker push trausch/helloworld

# Connect to kubernetes
export KUBECONFIG=`pwd`/../../k3s.yaml
kubectl get nodes

# Deploy pod
kubectl apply -f deployment.yaml 
kubectl get deployments
kubectl describe deployments hwapp

# Deploy service
kubectl apply -f service.yaml
kubectl get services

# Use port forwarding to check working pod
kubectl port-forward deployment/hwapp 8000:5000 &
curl 0.0.0.0:8000

# Clean-up
kubectl delete service hwapp
kubectl delete deployment hwapp
kubectl get pods
