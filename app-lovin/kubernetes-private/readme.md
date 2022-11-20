gcloud beta secrets create teamcity-admin-pass --locations us-east1 --replication-policy user-managed
echo -n "Passw0rd" | gcloud beta secrets versions add teamcity-admin-pass --data-file=-
