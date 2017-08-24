#!/usr/bin/env bash

docker run -d --restart always -v /etcd_data:/etcd_data --net=host -p 2379:2379 -p 2380:2380 etcd:3.1.6 etcd \
--name etcd0 --data-dir=/etcd_data --initial-cluster-state new --initial-cluster-token k8s-etcd-cluster2 \
--initial-cluster etcd0=http://192.168.99.101:2380,etcd1=http://192.168.99.102:2380,etcd2=http://192.168.99.103:2380 \
--initial-advertise-peer-urls http://192.168.99.101:2380 --listen-peer-urls http://192.168.99.101:2380 \
--advertise-client-urls http://192.168.99.101:2379 --listen-client-urls http://192.168.99.101:2379,http://127.0.0.1:2379

docker run -d --restart always -v /etcd_data:/etcd_data --net=host -p 2379:2379 -p 2380:2380 etcd:3.1.6 etcd \
--name etcd1 --data-dir=/etcd_data --initial-cluster-state new --initial-cluster-token k8s-etcd-cluster2 \
--initial-cluster etcd0=http://192.168.99.101:2380,etcd1=http://192.168.99.102:2380,etcd2=http://192.168.99.103:2380 \
--initial-advertise-peer-urls http://192.168.99.102:2380 --listen-peer-urls http://192.168.99.102:2380 \
--advertise-client-urls http://192.168.99.102:2379 --listen-client-urls http://192.168.99.102:2379,http://127.0.0.1:2379

docker run -d --restart always -v /etcd_data:/etcd_data --net=host -p 2379:2379 -p 2380:2380 etcd:3.1.6 etcd \
--name etcd2 --data-dir=/etcd_data --initial-cluster-state new --initial-cluster-token k8s-etcd-cluster2 \
--initial-cluster etcd0=http://192.168.99.101:2380,etcd1=http://192.168.99.102:2380,etcd2=http://192.168.99.103:2380 \
--initial-advertise-peer-urls http://192.168.99.103:2380 --listen-peer-urls http://192.168.99.103:2380 \
--advertise-client-urls http://192.168.99.103:2379 --listen-client-urls http://192.168.99.103:2379,http://127.0.0.1:2379