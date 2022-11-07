#this is this one
#https://kubernetes.io/docs/tutorials/stateful-application/mysql-wordpress-persistent-volume/

#follow with these
#https://cloud.google.com/kubernetes-engine/docs/concepts/multi-cluster-ingress
#https://cloud.google.com/kubernetes-engine/docs/how-to/multi-cluster-ingress-setup#before_you_begin
#https://cloud.google.com/kubernetes-engine/docs/how-to/multi-cluster-ingress

#install the deployment gateway from here:
cd ~
git clone https://github.com/GoogleCloudPlatform/anthos-service-mesh-packages
cd anthos-service-mesh-packages
#create a namespace and label it for istio pod injection
kubectl create ns asm-ingress
REVISION=$(kubectl get deploy -n istio-system -l app=istiod -o \
jsonpath={.items[*].metadata.labels.'istio\.io\/rev'}'{"\n"}')
echo $REVISION
kubectl label namespace asm-ingress istio-injection- istio.io/rev=$REVISION --overwrite

k apply -f samples/gateways/istio-ingressgateway/ -n asm-ingress


kubectl create secret generic mysql \
    --from-literal=password="Passw0rd!"

gcloud compute addresses create ingress-ip --global

