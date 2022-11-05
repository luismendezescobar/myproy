#follow this one
#https://cloud.google.com/kubernetes-engine/docs/how-to/ingress-features#ingress


#follow also with the examples from here
#https://cloud.google.com/kubernetes-engine/docs/concepts/ingress-xlb
#https://cloud.google.com/kubernetes-engine/docs/how-to/ingress-http2
#https://cloud.google.com/service-mesh/docs/by-example/canary-deployment


#To use a BackendConfig to configure Cloud CDN, perform the following tasks:

#CDN example

kubectl create namespace cdn-how-to
kubectl apply -f 01-deployment.yaml
kubectl apply -f 02-backendconfig.yaml
kubectl apply -f 03-service.yaml

#Create a reserved IP address:
gcloud compute addresses create cdn-how-to-address --global

kubectl apply -f 04-ingress.yaml

kubectl describe ingress my-ingress --namespace=cdn-how-to | grep "Address"

#Validate Cloud CDN caching
curl -v ADDRESS/?cache=true

#also you can validate with this command:
for i in {1..15};do curl -s -w "%{time_total}\n" -o /dev/null http://(your-frontend-ip)/index.html; done
for i in {1..15};do curl -s -w "%{time_total}\n" -o /dev/null http://34.160.40.175; done
