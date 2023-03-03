map_to_subnet = {
  /*
  subnet-name-10-x-x-x-20 = {
    project       = "shared-vpc-project"
    subnet        = "subnet-name-10-x-x-x-20"
    subnet_region = "us-central1"
    principal = [
      "serviceAccount:service-172474694@dataflow-service-producer-prod.iam.gserviceaccount.com",
    ]
  },
  */
  subnet-02 = {
    project       = "central-gcp-vpc-non-prod-37070"
    subnet        = "subnet-02"
    subnet_region = "us-central1"
    principal = [
      "serviceAccount:410553540498-compute@developer.gserviceaccount.com",
      "serviceAccount:sa-test@new-luis-id.iam.gserviceaccount.com",
    ]
  },
  
  subnet-us-central1-10-10-20-0-24 = {
    project       = "net-shared-vpc-prod-a72t"
    subnet        = "subnet-us-central1-10-10-20-0-24"
    subnet_region = "us-central1"
    principal = [
      "serviceAccount:638944924927-compute@developer.gserviceaccount.com",      
    ]
  },

}



