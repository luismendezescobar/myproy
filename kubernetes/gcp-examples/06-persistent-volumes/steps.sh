#this is this one
#https://kubernetes.io/docs/tutorials/stateful-application/mysql-wordpress-persistent-volume/

#follow with these
#https://cloud.google.com/kubernetes-engine/docs/concepts/multi-cluster-ingress
#https://cloud.google.com/kubernetes-engine/docs/how-to/multi-cluster-ingress-setup#before_you_begin
#https://cloud.google.com/kubernetes-engine/docs/how-to/multi-cluster-ingress

kubectl create secret generic mysql \
    --from-literal=password="Passw0rd!"

gcloud compute addresses create ingress-ip --global