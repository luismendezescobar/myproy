#                                           From service to mesh
#https://cloud.google.com/architecture/exposing-service-mesh-apps-through-gke-ingress
#what is the difference with this one?
#https://cloud.google.com/service-mesh/docs/managed/provision-managed-anthos-service-mesh-asmcli#mesh-ca
#other interesting articles
#https://alwaysupalwayson.com/posts/2021/04/cloud-armor/
#https://www.linkedin.com/pulse/integrating-istio-gcp-load-balancer-serdar-y%C4%B1ld%C4%B1r%C4%B1m/?trk=public_profile_article_view
#permissions
#https://github.com/GoogleCloudPlatform/anthos-sample-deployment
#configure the project info
export PROJECT=$(gcloud info --format='value(config.project)')
export PROJECT_NUMBER=$(gcloud projects describe ${PROJECT} --format="value(projectNumber)")
gcloud config set project ${PROJECT}
#Create a working directory:
mkdir -p ${HOME}/edge-to-mesh
cd ${HOME}/edge-to-mesh
export WORKDIR=`pwd`

############################################# Creating GKE clusters ##########################################
export CLUSTER_NAME=edge-to-mesh
export CLUSTER_LOCATION=us-west1-a

gcloud services enable container.googleapis.com
#Create a GKE cluster.
#To use a cloud ingress, you must have the HTTP load balancing add-on enabled.
#GKE clusters have HTTP load balancing enabled by default; you must not disable it.
#To use the managed Anthos Service Mesh, you must apply the mesh_id label on the cluster.
gcloud container clusters create ${CLUSTER_NAME} \
    --machine-type=n1-standard-2 \
    --num-nodes=3 \
    --zone ${CLUSTER_LOCATION} \
    --enable-ip-alias \
    --workload-pool=${PROJECT}.svc.id.goog \
    --release-channel rapid \
    --addons HttpLoadBalancing \
    --labels mesh_id=proj-${PROJECT_NUMBER}
#Ensure that the cluster is running:
sleep 10
gcloud container clusters list
#Connect to the cluster:
gcloud container clusters get-credentials ${CLUSTER_NAME} \
    --zone ${CLUSTER_LOCATION} \
    --project ${PROJECT}

############################################### Installing a service mesh ###################################
#Enable the required APIs:
gcloud services enable \
    gkehub.googleapis.com \
    mesh.googleapis.com
#Enable Anthos Service Mesh on the fleet:
gcloud container fleet mesh enable
#Register the cluster to the fleet:
gcloud container fleet memberships register ${CLUSTER_NAME} \
    --gke-cluster ${CLUSTER_LOCATION}/${CLUSTER_NAME} \
    --enable-workload-identity

#Enable automatic control plane management and managed data plane:
gcloud container fleet mesh update \
    --management automatic \
    --memberships ${CLUSTER_NAME}
#After a few minutes, verify that the control plane status is ACTIVE:
sleep 60
gcloud container fleet mesh describe

############################################### Deploy an ingress gateway#######################
#In Cloud Shell, create a dedicated asm-ingress namespace:
kubectl create namespace asm-ingress
#Add a namespace label to the asm-ingress namespace:
#Labeling the asm-ingress namespace with istio-injection=enabled 
#instructs Anthos Service Mesh to automatically inject Envoy sidecar proxies 
#when an application is deployed.
kubectl label namespace asm-ingress istio-injection=enabled
#apply the yaml file that is already in the directory
kubectl apply -f 01-ingress-deployment.yaml
#Deploy ingress-service.yaml in your cluster to create the Service resource:
kubectl apply -f 02-ingress-service.yaml
#Deploy ingress-service.yaml in your cluster to create the Service resource:
kubectl apply -f 03-ingress-backendconfig.yaml