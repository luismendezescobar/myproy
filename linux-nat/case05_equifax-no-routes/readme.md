#Create readme firewall
#Forwarding rules


gcloud compute routes create \
from-shared-to-local \
--project=triggering-a-198-f5b9c571 \
--network=vpc-shared \
--priority=1000 \
--destination-range=10.10.11.0/24 \
--next-hop-ilb=forwarding-rule-shared \
--next-hop-ilb-region=us-east1



gcloud compute routes \
create from-local-to-shared \
--project=triggering-a-198-f5b9c571 \
--network=vpc-local --priority=1000 \
--destination-range=10.10.10.0/24 \
--next-hop-ilb=forwarding-rule-local \
--next-hop-ilb-region=us-east1
















bad rules---------------------------------------------
\
--tags=dest-ta-cse-rd1-dev-npe-gke1-0



gcloud compute routes create \
from-local-to-shared \
--network=vpc-local \
--destination-range=10.10.11.0/24  \
--next-hop-ilb=forwarding-rule-local






\
--tags=dest-rd1-dev-vpc-1-useast1-subnet1-isolated



#the last good full version is: case05_equifax-full