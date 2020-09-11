# A local kubernetes cluster for testing

## Create ssh key to access the ubuntu instances

`ssh-keygen -b 2048 -f ~/.ssh/multipass -t rsa -q -N ""`

## Create cloud-init file with public multipass key

`yq new 'ssh_authorized_keys[+]' "$(cat ~/.ssh/multipass.pub)" > cloud-config.yaml`

## Launch local kubernetes cluster using multipass and k3s

`./launch.sh`

## Clean-up kubernetes cluster and ubuntu instances

`./destroy.sh`
