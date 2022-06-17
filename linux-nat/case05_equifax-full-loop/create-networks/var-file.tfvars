project_id="playground-s-11-0a37ddf4"  #update the project here
//also add the project account on line 527, no needed anymore


vpc_info = {
    "vpc-shared"={
        auto_create_subnetworks=false
        subnets = [
            {
                subnet_name     = "vpc-shared-us-east1-sub"
                subnet_ip       = "10.10.10.0/24" 
                subnet_region   =  "us-east1"
                description     = "This subnet has a description"
            }
        ]
        secondary_ranges={}
    }
    "vpc-local"={
        auto_create_subnetworks=false
        subnets = [
            {
                subnet_name     = "vpc-local-us-east1-sub"
                subnet_ip       = "10.10.11.0/24" 
                subnet_region   =  "us-east1"
            }
        ]
        secondary_ranges={}
    }
}

firewall_rules = {
 "vpc-shared-ssh-allow"= {
    network_name = "vpc-shared"    
    rules = [ {
      name                  ="vpc-shared-ssh-allow"
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
          ports = [ "22" ]
      }]
      deny=[]
      log_config={
          metadata="INCLUDE_ALL_METADATA"
      }
      
    } ]    
  },
  "vpc-local-ssh-allow"= {
    network_name = "vpc-local"    
    rules = [ {
      name                  ="vpc-local-ssh-allow"
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
          ports = [ "22" ]
      }]
      deny=[]
      log_config={
          metadata="INCLUDE_ALL_METADATA"
      }      
    } ]    
  },
  "vpc-shared-allow-all-internal"= {
    network_name = "vpc-shared"    
    rules = [ {
      name                  ="vpc-shared-allow-all-internal"
      description           =null
      direction             ="INGRESS"
      priority              =null
      ranges                =["10.10.10.0/24"]
      source_tags           =null
      source_service_accounts = null
      target_tags             = null
      target_service_accounts = null
      allow=[
        {
          protocol = "icmp"
          ports = []
        },
        {
          protocol = "tcp"
          ports = []
        },
        {
          protocol = "udp"
          ports = []
        },            
      ]
      deny=[]
      log_config={
          metadata="INCLUDE_ALL_METADATA"
      }      
    } ]    
  },
  "vpc-local-allow-all-internal"= {
    network_name = "vpc-local"    
    rules = [ {
      name                  ="vpc-local-allow-all-internal"
      description           =null
      direction             ="INGRESS"
      priority              =null
      ranges                =["10.10.11.0/24"]
      source_tags           =null
      source_service_accounts = null
      target_tags             = null
      target_service_accounts = null
      allow=[
        {
          protocol = "icmp"
          ports = []
        },
        {
          protocol = "tcp"
          ports = []
        },
        {
          protocol = "udp"
          ports = []
        },            
      ]
      deny=[]
      log_config={
          metadata="INCLUDE_ALL_METADATA"
      }      
    } ]    
  },
  "vpc-shared-allow-from-local"= {
    network_name = "vpc-shared"    
    rules = [ {
      name                  ="vpc-shared-allow-from-local"
      description           =null
      direction             ="INGRESS"
      priority              =null
      ranges                =["10.10.11.0/24"]
      source_tags           =null
      source_service_accounts = null
      target_tags             = null
      target_service_accounts = null
      allow=[
        {
          protocol = "icmp"
          ports = []
        },
        {
          protocol = "tcp"
          ports = []
        },
        {
          protocol = "udp"
          ports = []
        },            
      ]
      deny=[]
      log_config={
          metadata="INCLUDE_ALL_METADATA"
      }      
    } ]    
  },
  "vpc-shared-allow-from-spoke"= {
    network_name = "vpc-shared"    
    rules = [ {
      name                  ="vpc-shared-allow-from-spoke"
      description           =null
      direction             ="INGRESS"
      priority              =null
      ranges                =["10.10.12.0/24"]
      source_tags           =null
      source_service_accounts = null
      target_tags             = null
      target_service_accounts = null
      allow=[
        {
          protocol = "icmp"
          ports = []
        },
        {
          protocol = "tcp"
          ports = []
        },
        {
          protocol = "udp"
          ports = []
        },            
      ]
      deny=[]
      log_config={
          metadata="INCLUDE_ALL_METADATA"
      }      
    } ]    
  },
  "vpc-local-allow-from-shared"= {
    network_name = "vpc-local"    
    rules = [ {
      name                  ="vpc-local-allow-from-shared"
      description           =null
      direction             ="INGRESS"
      priority              =null
      ranges                =["10.10.10.0/24"]
      source_tags           =null
      source_service_accounts = null
      target_tags             = null
      target_service_accounts = null
      allow=[
        {
          protocol = "icmp"
          ports = []
        },
        {
          protocol = "tcp"
          ports = []
        },
        {
          protocol = "udp"
          ports = []
        },            
      ]
      deny=[]
      log_config={
          metadata="INCLUDE_ALL_METADATA"
      }      
    } ]    
  },
  "vpc-local-allow-from-spoke"= {
    network_name = "vpc-local"    
    rules = [ {
      name                  ="vpc-local-allow-from-spoke"
      description           =null
      direction             ="INGRESS"
      priority              =null
      ranges                =["10.10.12.0/24"]
      source_tags           =null
      source_service_accounts = null
      target_tags             = null
      target_service_accounts = null
      allow=[
        {
          protocol = "icmp"
          ports = []
        },
        {
          protocol = "tcp"
          ports = []
        },
        {
          protocol = "udp"
          ports = []
        },            
      ]
      deny=[]
      log_config={
          metadata="INCLUDE_ALL_METADATA"
      }      
    } ]    
  },
  "vpc-shared-allow-health-check"= {
    network_name = "vpc-shared"    
    rules = [ {
      name                  ="vpc-shared-allow-health-check"
      description           =null
      direction             ="INGRESS"
      priority              =null
      ranges                =["130.211.0.0/22","35.191.0.0/16"]
      source_tags           =null
      source_service_accounts = null
      target_tags             = null
      target_service_accounts = null
      allow=[
        {
          protocol = "tcp"
          ports = []
        },
      ]
      deny=[]
      log_config={
          metadata="INCLUDE_ALL_METADATA"
      }      
    } ]    
  },
  "vpc-local-allow-health-check"= {
    network_name = "vpc-local"    
    rules = [ {
      name                  ="vpc-local-allow-health-check"
      description           =null
      direction             ="INGRESS"
      priority              =null
      ranges                =["130.211.0.0/22","35.191.0.0/16"]
      source_tags           =null
      source_service_accounts = null
      target_tags             = null
      target_service_accounts = null
      allow=[
        {
          protocol = "tcp"
          ports = []
        },
      ]
      deny=[]
      log_config={
          metadata="INCLUDE_ALL_METADATA"
      }      
    } ]    
  },
}


cloud_nat_map ={
  "cloud-nat-us-east1-vpc-shared" = {
    region                  ="us-east1"
    router_name             = "router-nat-us-east1-vpc-shared"
    bgp                     = {
      "asn"               ="64514",
      "advertise_mode"    = "DEFAULT",
      "advertised_groups" = ["ALL_SUBNETS"],
    }
    network                 = "vpc-shared"
    nat_ip_allocate_option  = false
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
    log_config_enable       = true
    log_config_filter       = "ERRORS_ONLY"
  },
  "cloud-nat-us-east1-vpc-local" = {
    region                  ="us-east1"
    router_name             = "router-nat-us-east1-vpc-local"
    bgp                     = {
      "asn"               ="64514",
      "advertise_mode"    = "DEFAULT",
      "advertised_groups" = ["ALL_SUBNETS"],
    }
    network                 = "vpc-local"
    nat_ip_allocate_option  = false
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
    log_config_enable       = true
    log_config_filter       = "ERRORS_ONLY"
  },

}

