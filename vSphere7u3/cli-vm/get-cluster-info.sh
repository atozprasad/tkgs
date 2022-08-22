#!/bin/bash
./01-access-supervisor.sh
figlet "Cluster Info"
kubectl cluster-info
read -p "Next ..."

figlet "API Resources"
kubectl api-resources -o wide
read -p "Next ..."
