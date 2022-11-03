kubectl apply -f web-deployment.yaml
kubectl apply -f web-service.yaml
kubectl apply -f basic-ingress.yaml

gcloud compute addresses create web-static-ip --global
sleep 10
kubectl apply -f basic-ingress-static-ip.yaml

#check the external ip
kubectl get ingress basic-ingress

#add an additional web service

#You can run multiple services on a single load balancer and public IP 
#by configuring routing rules on the Ingress. 
#By hosting multiple services on the same Ingress, 
#you can avoid creating additional load balancers 
#(which are billable resources) for every Service 
#that you expose to the internet.

kubectl apply -f web-deployment-v2.yaml
kubectl apply -f web-service2.yaml
kubectl apply -f basic-ingress2.yaml