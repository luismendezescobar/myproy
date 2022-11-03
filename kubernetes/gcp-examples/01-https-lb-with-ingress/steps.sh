kubectl apply -f web-deployment.yaml
kubectl apply -f web-service.yaml
kubectl apply -f basic-ingress.yaml

gcloud compute addresses create web-static-ip --global
sleep 10
kubectl apply -f basic-ingress-static-ip.yaml