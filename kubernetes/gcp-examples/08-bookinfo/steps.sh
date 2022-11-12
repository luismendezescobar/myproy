#in this example we created something similar to the example number 04-from-edge-to-mesh
#but we used the book revision app and only used port 80
#we use the below example from another tutorial
#it's similar to the notebook app
#https://kruschecompany.com/istio-service-mesh-kubernetes/

#create a namespace and label it for istio pod injection
kubectl create ns asm-ingress
REVISION=$(kubectl get deploy -n istio-system -l app=istiod -o \
jsonpath={.items[*].metadata.labels.'istio\.io\/rev'}'{"\n"}')
echo $REVISION
kubectl label namespace asm-ingress istio-injection- istio.io/rev=$REVISION --overwrite
gcloud compute addresses create ingress-ip --global


alias k=kubectl
k apply -f istio-ingressgateway/


#Create a namespace for the application
#and label to ahve the istion injection enabled

kubectl create ns mesh
kubectl label namespace mesh istio-injection- istio.io/rev=$REVISION --overwrite



#This is a set of standard api deployments and services 
#for deploying a regular application in kubernetes. 
#In this example, we use one version of Gateway 
#and 2 versions of books and ratings. 
#In service selector is registered only to the name 
#of the application, and not to the version; 
#we will configure routing to a specific version 
#using Istio




k apply -f 02-backend-config.yaml
k apply -f 03-ingress.yaml
k apply -f 04-gateway.yaml


kubectl apply -f ~/asm_output/istio-1.15.3-asm.1/samples/bookinfo/platform/kube/bookinfo.yaml