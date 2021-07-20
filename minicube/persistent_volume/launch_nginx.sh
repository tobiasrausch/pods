#!/bin/bash

# Create persistent volume
kubectl create -f pv.yaml
sleep 5
kubectl get pv
kubectl describe pv

kubectl create -f pvc.yaml
sleep 5
kubectl get pv

kubectl create -f nginx.yaml
sleep 5
kubectl get pvc

# Create service
kubectl get deployments
kubectl expose deployment/nginx-with-pv
sleep 5
kubectl get svc

# Get external IP
kubectl create -f ingress.yaml
sleep 5
kubectl get svc

# Fetch external IP
kubectl get ingress
curl -k https://192.168.49.2/web

