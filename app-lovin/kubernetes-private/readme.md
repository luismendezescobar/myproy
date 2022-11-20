gcloud beta secrets create teamcity-admin-pass --locations us-east1 --replication-policy user-managed
echo -n "Passw0rd" | gcloud beta secrets versions add teamcity-admin-pass --data-file=-

gcloud compute addresses list --global --filter="purpose=VPC_PEERING"

gcloud services vpc-peerings list \
    --network=main-vpc \
    --project=triggering-a-198-39e6aa97
