#!/bin/bash
clear
source ./tkc.env
source ../vns.env
kubectl vsphere login --server https://${SUPERVISOR_CLUSTER_IP} --insecure-skip-tls-verify  -u ${VS_NS_USER}
kubectl config use-context ${VS_NAMESPACE} 

## Login as VSN_ADMIN
source ./templates/tkc-cluster.conf
rm -f ./generated/create-tkc.yaml ./generated/temp.yaml
( echo "cat <<EOF >./generated/create-tkc.yaml";
  cat ./templates/create-tkc.yaml.template;
  echo "EOF";
) >./generated/temp.yaml
. ./generated/temp.yaml
cat ./generated/create-tkc.yaml
read -p "Press enter to apply the TKC Cluster creation yaml ... "
kubectl apply -f ./generated/create-tkc.yaml
rm ./generated/temp.yaml 

