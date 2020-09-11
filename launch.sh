#!/bin/bash

# Launch nodes
multipass launch -n master --cloud-init cloud-config.yaml
multipass launch -n node1 --cloud-init cloud-config.yaml
multipass launch -n node2 --cloud-init cloud-config.yaml
multipass list

# Install k3s
multipass exec master -- bash -c "curl -sfL https://get.k3s.io | sh -"

# Token to join clusters
TOKEN=$(multipass exec master sudo cat /var/lib/rancher/k3s/server/node-token)

# IP of master
IP=$(multipass info master | grep IPv4 | awk '{print $2}')
#ssh -i ~/.ssh/multipass ubuntu@${IP}

# Join nodes
multipass exec node1 -- bash -c "curl -sfL https://get.k3s.io | K3S_URL=\"https://$IP:6443\" K3S_TOKEN=\"$TOKEN\" sh -"
multipass exec node2 -- bash -c "curl -sfL https://get.k3s.io | K3S_URL=\"https://$IP:6443\" K3S_TOKEN=\"$TOKEN\" sh -"

# Takes a bit until nodes are ready
sleep 10

# Get nodes remotely
multipass exec master -- sudo kubectl get nodes

# Get kubeconfig and replace IP
multipass exec master -- sudo cat /etc/rancher/k3s/k3s.yaml > k3s.yaml
sed -i '' "s/127.0.0.1/$IP/" k3s.yaml

# Get nodes from local machines
export KUBECONFIG=`pwd`/k3s.yaml
kubectl get nodes

# Configure the node roles:
kubectl label node master node-role.kubernetes.io/master=""
kubectl label node node1 node-role.kubernetes.io/node=""
kubectl label node node2 node-role.kubernetes.io/node=""

# Configure taint NoSchedule for master
kubectl taint node master node-role.kubernetes.io/master=effect:NoSchedule
kubectl get nodes

# Launch & delete nginx for testing
kubectl create deploy nginx --image=nginx
kubectl create svc nodeport nginx --tcp=30001:80 --node-port=30001
sleep 10 && curl http://${IP}:30001
kubectl delete svc nginx
kubectl delete deploy nginx
