#!/bin/bash

minikube start
kubectl get nodes
kubectl get all

# namespaces
kubectl get ns
kubectl explain ns

# Launch simple counter
kubectl create -f counter.yaml
sleep 5
kubectl get jobs
sleep 5
kubectl describe jobs/counter
sleep 5
kubectl logs jobs/counter
sleep 5
kubectl delete jobs/counter
