project_id="playground-s-11-bc35469b"  #update the project here
//also add the project account on line 527, no needed anymore
service_account= {
  email= "678372662242-compute@developer.gserviceaccount.com"
  scopes= ["cloud-platform"]
}


vpc_info = {
    "vpc-shared"={
        auto_create_subnetworks=false
        subnets = [
            {
                subnet_name     = "vpc-shared-us-central1-sub"
                subnet_ip       = "10.10.10.0/24" 
                subnet_region   =  "us-central1"
                description     = "This subnet has a description"
            },
        ]
        secondary_ranges={}
    }
    "vpc-local"={
        auto_create_subnetworks=false
        subnets = [
            {
                subnet_name     = "vpc-local-us-central1-sub"
                subnet_ip       = "10.10.11.0/24" 
                subnet_region   =  "us-central1"
            },
        ]
        secondary_ranges={}
    } 
    "vpc-google"={
        auto_create_subnetworks=false
        subnets = [
            {
                subnet_name     = "vpc-google-us-central1-sub"
                subnet_ip       = "10.10.12.0/24" 
                subnet_region   =  "us-central1"
            },
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
  "vpc-google-ssh-allow"= {
    network_name = "vpc-google"    
    rules = [ {
      name                  ="vpc-google-ssh-allow"
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
  "vpc-google-allow-all-internal"= {
    network_name = "vpc-google"    
    rules = [ {
      name                  ="vpc-google-allow-all-internal"
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
      target_tags             = ["allow-health-check"]
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
      target_tags             = ["allow-health-check"]
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
  "cloud-nat-us-central1-vpc-shared" = {
    region                  ="us-central1"
    router_name             = "router-nat-us-central1-vpc-shared"
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
}

/*
gcloud compute images list

PROJECT: centos-cloud
FAMILY: centos-7

PROJECT: centos-cloud
FAMILY: centos-stream-8
*/

instance_template_map = {
  "nat-server" = {
    name_prefix       = "nat-server"
    zone              = "us-central1-b"
    region            = "us-central1"
    machine_type      = "e2-medium"
    source_image      = "centos-7"
    source_image_family="centos-7"
    source_image_project="centos-cloud"
    disk_size_gb      = "100"
    disk_type         = "pd-standard" 
    auto_delete       = "true"
    subnetwork        = "vpc-shared-us-central1-sub"    
    subnetwork_project= ""  //use var.project_id instead    
    init_script       = "./modules/nat_init.sh"  
    external_ip       = ["false"]
    can_ip_forward   = "true"
    network_tags = ["allow-health-check"]
    on_host_maintenance ="MIGRATE"
    additional_networks = [ {
      network       = "vpc-local"
      subnetwork    = "vpc-local-us-central1-sub"          
      subnetwork_project  = ""
      network_ip    = ""
      access_config  = []        
    }]
    //this part will be initalized in the top
    service_account={
      email  = ""
      scopes = ["cloud-platform"]
    }
    
  },
}


mig_map = {
  "mig-nat" = {
    hostname                  = "mig-nat"
    region                    ="us-central1"
    distribution_policy_zones =["us-central1-b","us-central1-c"]
    update_policy =[{
      instance_redistribution_type = "PROACTIVE" #tries to maintain the zon distribution
      max_surge_fixed              = 3
      max_surge_percent            = null
      max_unavailable_fixed        = 0
      max_unavailable_percent      = null
      min_ready_sec                = null
      replacement_method           = "SUBSTITUTE"  #preserve names with RECREATE,SUBSTITUTE
      minimal_action               = "REPLACE"   #what to do when there is a change in the mig
      type                         = "PROACTIVE" #update right away
    }]
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
    max_replicas            = 5
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


load_balancer_info = {
  "lb-backend-local" = {
    region                = "us-central1"
    protocol              = "TCP"
    load_balancing_scheme = "INTERNAL" 
    session_affinity      = "CLIENT_IP"
    balancing_mode        = "CONNECTION"
    vpc                   = "vpc-local"
    forwarding_name       = "forwarding-rule-local"   
    ip_protocol           = "TCP"    
    all_ports             = true
    allow_global_access   = false
    network               = "vpc-local"
    subnetwork            = "vpc-local-us-central1-sub"            
  }
}

server_vm_info = {
  "shared-client01" = {
      zone              = "us-central1-b"
      instance_type     = "e2-medium"
      //gcloud compute images list
      source_image      = "centos-cloud/centos-7"
      boot_disk_size_gb = 30
      boot_disk_type    = "pd-standard" 
      auto_delete       = true
      subnet_name       = "vpc-shared-us-central1-sub"
      description       = "bastion to manage all"
      init_script       = "./modules/create-vm/init.sh"  
      external_ip       = ["false"]
      can_ip_forward   = false
      network_tags = ["no-ip"]
      additional_disks = []
  },
  "local-client01" = {
      zone              = "us-central1-b"
      instance_type     = "e2-medium"
      //gcloud compute images list
      #source_image      = "efx-centos-7/efx-centos7"
      source_image      = "centos-cloud/centos-7"
      boot_disk_size_gb = 30
      boot_disk_type    = "pd-standard" 
      auto_delete       = true
      subnet_name       = "vpc-local-us-central1-sub"
      description       = "bastion to manage all"
      init_script       = "./modules/create-vm/init.sh"  
      external_ip       = ["false"]
      can_ip_forward   = false
      network_tags = ["no-ip"]
      additional_disks = []
  },
  "google-client01" = {
      zone              = "us-central1-b"
      instance_type     = "e2-medium"
      //gcloud compute images list
      #source_image      = "efx-centos-7/efx-centos7"
      source_image      = "centos-cloud/centos-7"
      boot_disk_size_gb = 30
      boot_disk_type    = "pd-standard" 
      auto_delete       = true
      subnet_name       = "vpc-google-us-central1-sub"
      description       = "bastion to manage all"
      init_script       = "./modules/create-vm/init.sh"  
      external_ip       = ["false"]
      can_ip_forward   = false
      network_tags = ["no-ip"]
      additional_disks = []
  },


}