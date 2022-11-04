#The big picture
#Here's an overview of the steps in this topic:
#Create a Deployment.
#Create a Service.
#Create two certificate files and two key files or two ManagedCertificate objects. Ensure you configure these certificates in the same project and same namespace as where the load balancer is deployed.
#Create an Ingress that uses either Secrets or pre-shared certificates. As a result of creating the Ingress, GKE creates and configures an HTTP(S) load balancer.
#Test the HTTP(S) load balancer.

#You can provide an HTTPS load balancer with SSL certificates using one of three methods:
#Google-managed SSL certificates. Refer to the managed certificates page for information on how to use them.
#Google Cloud SSL Certificate that you are managing yourself. It uses a pre-shared certificate previously uploaded to your Google Cloud project.
#Kubernetes Secrets. The Secret holds a certificate and key that you create yourself. To use a Secret, add its name in the tls field of your Ingress manifest.

kubectl apply -f 01-deployment.yaml
kubectl apply -f 02-service.yaml

######################################## Get the static ip and configure DNS #########
#In Cloud Shell, create a global static IP for the Google Cloud load balancer:
#This static IP is used by the Ingress resource and allows the IP to remain 
#the same, even if the external load balancer changes.
gcloud compute addresses create ingress-ip --global
#Get the static IP address:
export GCLB_IP=$(gcloud compute addresses describe ingress-ip --global --format "value(address)")
echo ${GCLB_IP}


#This tutorial uses Endpoints instead of creating a managed DNS zone. 
#Endpoints provides a free Google-managed DNS record for a public IP.
#The YAML specification defines the public DNS record in the form of:
#frontend.endpoints.${PROJECT}.cloud.goog, 
#where ${PROJECT} is your unique project number.
gcloud endpoints services deploy 03-dns-spec.yaml

##################################### Provision the TLS certificate ######
#This YAML file specifies that the DNS name created through Endpoints 
#is used to provision a public certificate. Because Google fully manages 
#the lifecycle of these public certificates, they are automatically generated 
#and rotated on a regular basis without direct user intervention.

kubectl apply -f 04-managed-cert.yaml

kubectl apply -f 05-managed-cert.yaml

#Inspect the ManagedCertificate resource to check the progress of 
#certificate generation:
kubectl describe managedcertificate gke-ingress-cert-01 
kubectl describe managedcertificate gke-ingress-cert-02



kubectl apply -f 06-ingress.yaml

#test first domain
curl -v https://hello.endpoints.triggering-a-198-8487f60b.cloud.goog

curl -v https://luismendeze.com