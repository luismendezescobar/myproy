gcloud beta secrets create teamcity-admin-pass --locations us-east1 --replication-policy user-managed
echo -n "Passw0rd" | gcloud beta secrets versions add teamcity-admin-pass --data-file=-

gcloud compute addresses list --global --filter="purpose=VPC_PEERING"

gcloud services vpc-peerings list \
    --network=main-vpc \
    --project=triggering-a-198-39e6aa97


#login to the container for teamcity server
k exec -it teamcity-deployment-7b56bc4dcd-gzs8q -c teamcity /bin/bash

#this is to get the authentication token
cat /opt/teamcity/logs/teamcity-server.log  |grep "Super user authentication token"

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