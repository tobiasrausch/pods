#!/bin/bash

minikube start
minikube addons enable ingress
minikube ssh
# Inside container run
# mkdir /tmp/pv && echo "Hello from tmp/pv" > /tmp/pv/index.html && exit


