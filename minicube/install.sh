#!/bin/bash

# Install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v1.22.0/minikube-linux-amd64
chmod +x minikube
sudo mv minikube /usr/local/bin/

