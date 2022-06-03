project_id="playground-s-11-81a88700"  #update the project here

vpc_info = {
    "vpc-shared"={
        auto_create_subnetworks=false
        subnetworks = [
            {
                subnet_name     = "vpc-shared-us-east1-sub"
                ip_cidr_range   = "10.10.10.0/24" 
                region          =  "us-east1"
            }
        ]
    }
    "vpc-local"={
        auto_create_subnetworks=false
        subnetworks = [
            {
                subnet_name     = "vpc-local-us-east1-sub"
                ip_cidr_range   = "10.10.11.0/24" 
                region          =  "us-east1"
            }
        ]
    }
    "vpc-spoke"={
        auto_create_subnetworks=false
        subnetworks = [
            {
                subnet_name     = "vpc-spoke-us-east1-sub"
                ip_cidr_range   = "10.10.12.0/24" 
                region          =  "us-east1"
            }
        ]
    }
}
