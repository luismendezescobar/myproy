map_vpc_config ={
  net-shared-vpc-prod-a72t-vpc-core-prod = {
    project_id       = "net-shared-vpc-prod-a72t"
    network_name     = "vpc-core-prod"
    routing_mode     = "GLOBAL"
    subnets = [
        {
            subnet_name           = "subnet-us-central1-10-10-20-0-24"
            subnet_ip             = "10.10.20.0/24"
            subnet_region         = "us-central1"
            subnet_private_access = "true"
        },
        {
            subnet_name           = "subnet-us-west1-10-10-21-0-24"
            subnet_ip             = "10.10.21.0/24"
            subnet_region         = "us-west1"
            subnet_private_access = "true"
            subnet_flow_logs      = "false"
            description           = "This subnet has a description"
        },
    ]
    secondary_ranges = {
        subnet-us-central1-10-10-20-0-24 = [
            {
                range_name    = "subnet-us-central1-10-10-20-0-24-secondary-01"
                ip_cidr_range = "192.168.80.0/24"
            },
        ]
        subnet-us-west1-10-10-21-0-24 = []
    }    
    routes = []
  },  
}
