#this is this one
#https://kubernetes.io/docs/tutorials/stateful-application/mysql-wordpress-persistent-volume/

#follow with these
#https://cloud.google.com/kubernetes-engine/docs/concepts/multi-cluster-ingress
#https://cloud.google.com/kubernetes-engine/docs/how-to/multi-cluster-ingress-setup#before_you_begin
#https://cloud.google.com/kubernetes-engine/docs/how-to/multi-cluster-ingress

#install the deployment gateway from here:


#create a namespace and label it for istio pod injection
kubectl create ns asm-ingress
REVISION=$(kubectl get deploy -n istio-system -l app=istiod -o \
jsonpath={.items[*].metadata.labels.'istio\.io\/rev'}'{"\n"}')
echo $REVISION
kubectl label namespace asm-ingress istio-injection- istio.io/rev=$REVISION --overwrite

gcloud compute addresses create ingress-ip --global

kubectl create secret generic mysql-pass \
    --from-literal=password="Passw0rd"

alias k=kubectl






#creates the istio ingress gateway
k apply -f istio-ingressgateway/


k apply -f 02-backend-config.yaml
k apply -f 03-ingress.yaml
k apply -f 04-gateway.yaml
k apply -f 05-mysql-deployment.yaml
k apply -f 06-wordpress-deployment.yaml










#cd ~
#git clone https://github.com/GoogleCloudPlatform/anthos-service-mesh-packages
#cd anthos-service-mesh-packages
#create a namespace and label it for istio pod injection
#kubectl create ns asm-ingress
#REVISION=$(kubectl get deploy -n istio-system -l app=istiod -o \
#jsonpath={.items[*].metadata.labels.'istio\.io\/rev'}'{"\n"}')
#echo $REVISION
#kubectl label namespace asm-ingress istio-injection- istio.io/rev=$REVISION --overwrite

#k apply -f samples/gateways/istio-ingressgateway/ -n asm-ingress

