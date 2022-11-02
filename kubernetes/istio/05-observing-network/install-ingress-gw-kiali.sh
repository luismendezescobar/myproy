GATEWAY_NS=monitoring-gateway
kubectl create namespace $GATEWAY_NS
REVISION=$(kubectl get deploy -n istio-system -l app=istiod -o \
jsonpath={.items[*].metadata.labels.'istio\.io\/rev'}'{"\n"}')
kubectl label namespace $GATEWAY_NS \
istio.io/rev=$REVISION --overwrite
kubectl apply -n $GATEWAY_NS \
  -f /stio-ingressgateway
