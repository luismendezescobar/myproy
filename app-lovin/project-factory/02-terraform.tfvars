
map_for_project_factory = {

  service_project01 = {
    name              = "service-pf-test-1"
    billing_account   = "016AE0-A1405C-5DF4D8"
    create_group      = true
    folder_id         = "250869018475"
    group_name        = "service-pf-test-1"
    group_role        = "roles/viewer"
    org_id            = "65202286851"
    random_project_id = true
    sa_group          = "service-pf-test-1@luismendeze.com"
    shared_vpc        = "central-gcp-vpc-non-prod-37070"
    shared_vpc_subnets = [
        "projects/central-gcp-vpc-non-prod-37070/regions/us-west1/subnetworks/subnet-01",
        "projects/central-gcp-vpc-non-prod-37070/regions/us-central1/subnetworks/subnet-02",
    ]

  },
  


}









