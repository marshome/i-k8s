#!/usr/bin/env bash

#kubelet cert
openssl genrsa -out kubelet.key 2048
openssl req -new -key kubelet.key -out kubelet.csr -subj "/CN=kubelet"
openssl x509 -req -in kubelet.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out kubelet.crt -days 10000

sudo ./kubelet --require-kubeconfig true --kubeconfig=../master/kubeconfig.yaml --pod-manifest-path=../master/manifests