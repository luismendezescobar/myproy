project_id="triggering-a-198-8fd39b23" 

vpc_info = {
    "network"={
        auto_create_subnetworks=false
        subnets = [
          {
            subnet_name     = "us-central-subnet"
            subnet_ip       = "10.1.0.0/24" 
            subnet_region   =  "us-central1"
            description     = "Subnet for kubernetes"
            subnet_private_access = "true"
          },
          {
            subnet_name     = "private-services"
            subnet_ip       = "10.4.0.0/20" 
            subnet_region   =  "us-central1"
            description     = "Subnet for other services"
            subnet_private_access = "true"
          },
        ]
        secondary_ranges={
            us-central-subnet = [
              {
                range_name = "pods"
                ip_cidr_range ="10.2.0.0/20"
              },
              {
                range_name = "services"
                ip_cidr_range ="10.3.0.0/20"
              }
            ]
        }
    }
}

firewall_rules = {
 "vpc-network-allow-all"= {
    network_name = "network"    
    rules = [ {
      name                  ="vpc-network-allow-all"
      description           =null
      direction             ="INGRESS"
      priority              =null
      ranges                =["0.0.0.0/0"]
      source_tags           =null
      source_service_accounts = null
      target_tags             = null
      target_service_accounts = null
      allow=[{
        protocol = "tcp"
        ports = []
      },
      {
        protocol ="udp"
        ports= []        
      },
      {
        protocol ="icmp"
        ports= []        
      }
      ]
      deny=[]
      log_config={
          metadata="INCLUDE_ALL_METADATA"
      }
      
    }]    
  },
}



cloud_nat_map ={
  "cloud-nat-us-central1-vpc-network" = {
    region                  ="us-central1"
    router_name             = "nat-gateway"
    bgp                     = {
      "asn"               ="64514",
      "advertise_mode"    = "DEFAULT",
      "advertised_groups" = ["ALL_SUBNETS"],
    }
    network                 = "network"
    nat_ip_allocate_option  = false
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
    log_config_enable       = true
    log_config_filter       = "ERRORS_ONLY"
  },

}


storage_class = "REGIONAL"
bucket_location="us-central1"