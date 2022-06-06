project_id="playground-s-11-74401450"  #update the project here

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
    "vpc-spoke"={
        auto_create_subnetworks=false
        subnets = [
            {
                subnet_name     = "vpc-spoke-us-east1-sub"
                subnet_ip       = "10.10.12.0/24" 
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
  "vpc-spoke-ssh-allow"= {
    network_name = "vpc-spoke"    
    rules = [ {
      name                  ="vpc-spoke-ssh-allow"
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
  "vpc-spoke-allow-all-internal"= {
    network_name = "vpc-spoke"    
    rules = [ {
      name                  ="vpc-spoke-allow-all-internal"
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
  "vpc-spoke-allow-from-local"= {
    network_name = "vpc-spoke"    
    rules = [ {
      name                  ="vpc-spoke-allow-from-local"
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
  "vpc-spoke-allow-from-shared"= {
    network_name = "vpc-spoke"    
    rules = [ {
      name                  ="vpc-spoke-allow-from-shared"
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
  }
}

instance_template_map = {
  "nat-server" = {
    name_prefix       = "nat-server"
    zone              = "us-east1-b"
    region            = "us-east1"
    machine_type      = "e2-medium"
    source_image      = "centos-cloud/centos-stream-9"
    source_image_family="centos-stream-9"
    source_image_project="centos-cloud"
    disk_size_gb      = "100"
    disk_type         = "pd-standard" 
    auto_delete       = "true"
    subnetwork        = "vpc-shared-us-east1-sub"
    subnetwork_project= ""  //use var.project_id instead
    //subnet_name2      = "vpc-local-us-east1-sub"
    #description       = "linux centos nat server"
    init_script       = "./modules/nat_init.sh"  
    external_ip       = ["false"]
    can_ip_forward   = "true"
    network_tags = []  
    on_host_maintenance ="MIGRATE"
    additional_networks = [ {
      network       = "vpc-local"
      subnetwork    = "vpc-local-us-east1-sub"
      subnetwork_project  = ""
      network_ip    = ""
      access_config  = [// {
        //nat_ip        = ""
        //network_tier  = ""
     // }
      ]        
    }]
    service_account={
      email  = "665898570532-compute@developer.gserviceaccount.com"
      scopes = ["cloud-platform"]
    }
    
  },
}


mig_map = {
  "mig-nat" = {
    hostname                  = "mig-nat"
    region                    ="us-east1"
    distribution_policy_zones =["us-east1-b"]
    update_policy =[]
    health_check={
      type                = "tcp"
      initial_delay_sec   = 30
      check_interval_sec  = 30
      healthy_threshold   = 2
      timeout_sec         = 10
      unhealthy_threshold = 5
      response            = ""
      proxy_header        = "NONE"
      port                = 22
      request             = ""
      request_path        = ""
      host                = ""
    }
    autoscaling_enabled     =true
    max_replicas            = 3
    min_replicas            = 2
    cooldown_period         = 60
    autoscaling_cpu         = [
      {
        target = 0.6
      }
    ]
    autoscaling_metric      = []
    autoscaling_lb          = []
    autoscaling_scale_in_control={
      fixed_replicas   = null
      percent_replicas = null
      time_window_sec  = null
    }
  },
}


