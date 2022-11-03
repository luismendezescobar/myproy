GATEWAY_NS=monitoring-gateway
kubectl create namespace $GATEWAY_NS
REVISION=$(kubectl get deploy -n istio-system -l app=istiod -o \
jsonpath={.items[*].metadata.labels.'istio\.io\/rev'}'{"\n"}')
kubectl label namespace $GATEWAY_NS \
istio.io/rev=$REVISION --overwrite
kubectl apply -n $GATEWAY_NS \
  -f ./istio-ingressgateway

#download the correct version of istio to install the tools
#https://istio.io/latest/docs/setup/getting-started/#download
#table of versions
#https://kiali.io/docs/installation/installation-guide/prerequisites/
#install kiali
#https://kiali.io/docs/installation/quick-start/
#upload an executable
#git update-index --chmod=+x install-ingress-gw-kiali.sh

#curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.12 TARGET_ARCH=x86_64 sh -
