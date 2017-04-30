#!/usr/bin/env bash

kubectl create -f *.yaml
kubectl replace -f *.yaml