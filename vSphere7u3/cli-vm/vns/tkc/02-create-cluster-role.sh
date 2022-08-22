source ./tkc.env
source ../vns.env
mkdir -p ./generated
kubectl vsphere login --server https://${SUPERVISOR_CLUSTER_IP} --insecure-skip-tls-verify  -u ${VS_NS_USER} --tanzu-kubernetes-cluster-name ${TKC_CLUSTER_NAME}
kubectl config use-context ${TKC_CLUSTER_NAME}

## Login as VSN_ADMIN
source tkc-cluster.conf
rm -f ./generated/devops-psp.yaml ./generated/temp-devops-psp.yaml 
( echo "cat <<EOF >./generated/devops-psp.yaml";
  cat ./templates/devops-psp.yaml.template;
  echo "EOF";
) >./generated/temp-devops-psp.yaml 
. ./generated/temp-devops-psp.yaml
cat ./generated/devops-psp.yaml
read -p "Press enter to apply the TKC Cluster creation yaml ... "
kubectl apply -f ./generated/devops-psp.yaml
rm ./generated/temp-devops-psp.yaml
