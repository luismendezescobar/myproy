/*based on this article
https://dev.to/stack-lbs/securing-the-connectivity-between-a-gke-application-and-a-cloud-sql-database-4d6b
*/
/*

1. Manual commands, run this before the terraform
PROJECT_ID="triggering-a-198-db226a4e"
REGION="us-west1"
gcloud services enable secretmanager.googleapis.com --project $PROJECT_ID
gcloud beta secrets create wordpress-admin-user-password --locations $REGION --replication-policy user-managed
echo -n "changeme" | gcloud beta secrets versions add wordpress-admin-user-password --data-file=-
*/
/*
2. Run terraform now
*/
/*

3. run all the below commands along with the yamls
create the Kubernetes service account: 
(it's created with the yaml!! see line ~33 01-service-account.yaml)

#connect to kubernetes
gcloud container clusters get-credentials private --region $REGION --project $PROJECT_ID

#create namespace in kubernetes
kubectl create namespace wordpress

#replace the project id in the yaml file:service-account.yaml

sed -i "s/<PROJECT_ID>/$PROJECT_ID/g;" yamls/01-service-account.yaml

kubectl apply -f yamls/01-service-account.yaml -n wordpress

The Kubernetes service account will be used by the Cloud SQL Proxy deployment 
to access the Cloud SQL instance.
Allow the Kubernetes service account to impersonate the created 
Google service account by an IAM policy binding between the two:

gcloud iam service-accounts add-iam-policy-binding \
  --role roles/iam.workloadIdentityUser \
  --member "serviceAccount:$PROJECT_ID.svc.id.goog[wordpress/cloud-sql-access]" \
  cloud-sql-access@$PROJECT_ID.iam.gserviceaccount.com



*/


/* not always is needed.
if you get  ipv6 error , run this command
sudo -i

export APIS="googleapis.com www.googleapis.com storage.googleapis.com iam.googleapis.com container.googleapis.com cloudresourcemanager.googleapis.com"
for i in $APIS
do
  echo "199.36.153.10 $i" >> /etc/hosts
done

exit
*/


Listing private connections
gcloud services vpc-peerings list \
    --network=custom \
    --project=$PROJECT_ID

List allocated IP address ranges
gcloud compute addresses list --global --filter="purpose=VPC_PEERING"

sed -i "s/<CLOUD_SQL_PROJECT_ID>/$PROJECT_ID/g;s/<CLOUD_SQL_INSTANCE_NAME>/$(terraform output cloud-sql-instance-name | tr -d '"')/g;s/<CLOUD_SQL_REGION>/$REGION/g;" yamls/02-sql-proxy-deployment.yaml

kubectl apply -f yamls/02-sql-proxy-deployment.yaml -n wordpress
kubectl get pods -l app=cloud-sql-proxy -n wordpress --watch
kubectl logs cloud-sql-proxy-fb9968d49-hqlwb -n wordpress

kubectl create secret generic mysql \
    --from-literal=password=$(gcloud secrets versions access latest --secret=wordpress-admin-user-password --project $PROJECT_ID) -n wordpress

gcloud compute addresses create wordpress --global    
gcloud compute addresses list --global

kubectl apply -f yamls/03-wordpress-deployment.yaml -n wordpress
kubectl get pods -l app=wordpress -n wordpress --watch

kubectl apply -f yamls/04-backend.yaml -n wordpress

/*it's not needed as it will be done in godaddy*/
export PUBLIC_DNS_NAME=luismendeze.com
export PUBLIC_DNS_ZONE_NAME=luismendeze.com
gcloud dns record-sets transaction start --zone=$PUBLIC_DNS_ZONE_NAME
gcloud dns record-sets transaction add $(gcloud compute addresses list --filter=name=wordpress --format="value(ADDRESS)") --name=wordpress.$PUBLIC_DNS_NAME. --ttl=300 --type=A --zone=$PUBLIC_DNS_ZONE_NAME
gcloud dns record-sets transaction execute --zone=$PUBLIC_DNS_ZONE_NAME
sed -i "s/<DOMAIN_NAME>/wordpress.$PUBLIC_DNS_NAME/g;" infra/k8s/web/ssl.yaml
*/

#to create the certificate
kubectl create -f yamls/05-ssl.yaml -n wordpress  

#to redirect all from http to https
kubectl apply -f yamls/06-frontend-config.yaml -n wordpress