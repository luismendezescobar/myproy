#                                  full deploy from edge to mesh
#https://cloud.google.com/architecture/exposing-service-mesh-apps-through-gke-ingress
#set your gcp project

export PROJECT=$(gcloud info --format='value(config.project)')
export PROJECT_NUMBER=$(gcloud projects describe ${PROJECT} --format="value(projectNumber)")
gcloud config set project ${PROJECT}

#create your working directory
mkdir -p ${HOME}/edge-to-mesh
cd ${HOME}/edge-to-mesh
export WORKDIR=`pwd`
##################################################################################################
#                                        create your gke cluster
export CLUSTER_NAME=edge-to-mesh
export CLUSTER_LOCATION=us-west1-a
#To use a cloud ingress, you must have the HTTP load balancing add-on enabled. 
#GKE clusters have HTTP load balancing enabled by default; you must not disable it.
#To use the managed Anthos Service Mesh, you must apply the mesh_id label on the cluster.
gcloud container clusters create ${CLUSTER_NAME} \
    --machine-type=e2-standard-4 \
    --num-nodes=4 \
    --zone ${CLUSTER_LOCATION} \
    --enable-ip-alias \
    --workload-pool=${PROJECT}.svc.id.goog \
    --release-channel rapid \
    --addons HttpLoadBalancing \   
    --labels mesh_id=proj-${PROJECT_NUMBER}

#connect to the cluster
gcloud container clusters get-credentials ${CLUSTER_NAME} \
    --zone ${CLUSTER_LOCATION} \
    --project ${PROJECT}
######################################################################################################
#                           Installing a managed Anthos Service Mesh with fleet API.
#enable the apis
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
echo "verifying that the control plane status is ACTIVE, please wait 2 minutes"
sleep 120
gcloud container fleet mesh describe