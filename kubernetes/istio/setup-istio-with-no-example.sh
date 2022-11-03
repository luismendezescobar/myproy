cd ~
export PROJECT_ID=$(gcloud config get-value project)
export PROJECT_NUMBER=$(gcloud projects describe ${PROJECT_ID} \
    --format="value(projectNumber)")
export CLUSTER_NAME=central
export CLUSTER_ZONE=us-west1-c
export WORKLOAD_POOL=${PROJECT_ID}.svc.id.goog
export MESH_ID="proj-${PROJECT_NUMBER}"



gcloud services enable container.googleapis.com --project $PROJECT_ID
sleep 3
gcloud config set compute/zone ${CLUSTER_ZONE}
sleep 3
gcloud beta container clusters create ${CLUSTER_NAME} \
    --machine-type=n1-standard-1 \
    --num-nodes=3 \
    --workload-pool=${WORKLOAD_POOL} \
    --enable-stackdriver-kubernetes \
    --subnetwork=default \
    --release-channel=regular \
    --labels mesh_id=${MESH_ID}

kubectl create clusterrolebinding cluster-admin-binding   --clusterrole=cluster-admin   --user=$(whoami)@linuxacademygclabs.com

curl https://storage.googleapis.com/csm-artifacts/asm/asmcli_1.15 > asmcli
chmod +x asmcli

./asmcli install \
  --project_id $PROJECT_ID \
  --cluster_name $CLUSTER_NAME \
  --cluster_location $CLUSTER_ZONE \
  --fleet_id $PROJECT_ID \
  --output_dir ./asm_output \
  --enable_all \
  --option legacy-default-ingressgateway \
  --ca mesh_ca \
  --enable_gcp_components


REVISION=$(kubectl get deploy -n istio-system -l app=istiod -o \
jsonpath={.items[*].metadata.labels.'istio\.io\/rev'}'{"\n"}')
echo $REVISION

alias k=kubectl
kubectl label namespace default istio-injection- istio.io/rev=$REVISION --overwrite

#cd asm_output/istio-1.12.9-asm.3
#kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
#k get pods
#kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml

#kubectl get svc istio-ingressgateway -n istio-system
cd ~
#git clone https://github.com/luismendezescobar/myproy.git
git clone https://github.com/istio/istio.git

cd myproy/kubernetes/istio