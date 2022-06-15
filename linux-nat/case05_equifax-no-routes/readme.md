#Create readme firewall
#Forwarding rules

gcloud compute routes create \
from-local-to-shared \
--network="vpc-local" \
--destination-range="10.10.10.0/24"  \
--next-hop-ilb=forwarding-rule-shared


\
--tags=dest-ta-cse-rd1-dev-npe-gke1-0



gcloud compute routes create \
from-shared-to-local \
--network=ta-net-npe \
--destination-range=10.10.11.0/24  \
--next-hop-ilb=forwarding-rule-local






\
--tags=dest-rd1-dev-vpc-1-useast1-subnet1-isolated



#the last good full version is: case05_equifax-full