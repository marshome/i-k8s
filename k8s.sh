#!/usr/bin/env bash

# 主机名将用于node名称
vim /etc/hostname
# 主机名对应的网卡地址
vim /etc/hosts

# 重置master或者node
sudo kubeadm reset

# 启动master
sudo kubeadm init --apiserver-advertise-address=192.168.99.201 --pod-network-cidr=10.244.0.0/16
# 添加环境KUBECONFIG变量使用kubectl
# 复制admin.conf到其他机器使用kubectl。执行kubectl proxy，启动代理

# 查看集群信息
kubectl cluster-info

# 安装网络插件
kubectl apply -f https://raw.githubusercontent.com/weaveworks/weave/master/prog/weave-kube/weave-daemonset-k8s-1.6.yaml
kubectl apply -f https://raw.githubusercontent.com/romana/romana/master/containerize/specs/romana-kubeadm.yml
kubectl apply -f http://docs.projectcalico.org/v2.1/getting-started/kubernetes/installation/hosted/kubeadm/1.6/calico.yaml

# 启动node
kubeadm join --token 961e82.be5b0cf15e566aec 192.168.99.201:6443

# 安装ui插件
kubectl create -f https://git.io/kube-dashboard
kubectl proxy
http://localhost:8001/ui

# 系统资源监控
kubectl create -f https://raw.githubusercontent.com/luxas/heapster/1308dd71f0ba343895456b46d1bbf3238800b6f3/deploy/kube-config/rbac/heapster-rbac.yaml