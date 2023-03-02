map_to_vpc_non_prod = {
  central-gcp-vpc-non-prod-37070-vpc-core-non-prod = {
    project_id       = "central-gcp-vpc-non-prod-37070"
    network_name     = "vpc-core-non-prod"
    shared_vpc_host  = true
  },  
  /*
  central-gcp-vpc-non-prod-37070-vpc-mgmt-non-prod = {
    project_id       = "central-gcp-vpc-non-prod-37070"
    network_name     = "vpc-mgmt-non-prod"
    shared_vpc_host  = false         #It's only needed for first one.
  }
*/
}

/*
https://github.com/terraform-google-modules/terraform-google-network/tree/master/modules/vpc

https://github.com/terraform-google-modules/terraform-google-network/tree/master/modules/subnets
https://cloud.google.com/architecture/best-practices-vpc-design#general_principles_and_first_steps
*/
/*
map_to_vpc_prod = {
  net-shared-vpc-prod-a72t-vpc-core-prod = {
    project_id       = "net-shared-vpc-prod-a72t"
    network_name     = "vpc-core-prod"    
  },  

}
*/