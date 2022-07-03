project_id="playground-s-11-8f57a064"  #update the project here
//also add the project account on line 527, no needed anymore

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



server_nat_info = {
  "nat-server" = {
      gce_image_family      = "centos-7"
      compute_image_project = "centos-cloud"
      project_id            = ""
      machine_type     = "e2-medium"
      zone              = "us-central1-b"
      labels = {}
      auto_delete         = true
      kms_key_self_link   = ""
      disk_size           = 30
      disk_type           = "pd-standard" 
      subnetwork_project  = ""        
      subnetwork          = "vpc-shared-us-central1-sub"
      external_ip       = ["false"]
      additional_networks = [{
        network            = "vpc-local" 
        subnetwork         = "vpc-local-us-central1-sub"
        subnetwork_project = ""
        network_ip         = ""
        access_config      = []
      }]
      service_account = {
        email  = ""
        scopes = ["cloud-platform"]
      }
      tags                = []   
      metadata              = {}        
      startup_script       = "./modules/nat_init.sh"      
      description       = "Linux nat server for vertexIA"
      can_ip_forward   = true
      allow_stopping_for_update = false      
      additional_disks = []      
  },
  "isolated-client01" = {
      gce_image_family      = "centos-7"
      compute_image_project = "centos-cloud"
      project_id            = ""
      machine_type     = "e2-medium"
      zone              = "us-central1-b"
      labels = {}
      auto_delete         = true
      kms_key_self_link   = ""
      disk_size           = 30
      disk_type           = "pd-standard" 
      subnetwork_project  = ""        
      subnetwork          = "vpc-local-us-central1-sub"
      external_ip       = ["false"]
      additional_networks = []
      service_account = {
        email  = ""
        scopes = ["cloud-platform"]
      }
      tags                = []   
      metadata              = {}        
      startup_script       = "./modules/create-vm/init.sh"    
      description       = "Linux nat server for vertexIA"
      can_ip_forward   = true
      allow_stopping_for_update = false      
      additional_disks = []      
  },
  "shared-client01" = {
      gce_image_family      = "centos-7"
      compute_image_project = "centos-cloud"
      project_id            = ""
      machine_type     = "e2-medium"
      zone              = "us-central1-b"
      labels = {}
      auto_delete         = true
      kms_key_self_link   = ""
      disk_size           = 30
      disk_type           = "pd-standard" 
      subnetwork_project  = ""        
      subnetwork          = "vpc-shared-us-central1-sub"
      external_ip       = ["false"]
      additional_networks = []
      service_account = {
        email  = ""
        scopes = ["cloud-platform"]
      }
      tags                = []   
      metadata              = {}        
      startup_script       = "./modules/create-vm/init.sh"    
      description       = "Linux nat server for vertexIA"
      can_ip_forward   = true
      allow_stopping_for_update = false      
      additional_disks = []      
  },
  "google-client01" = {
      gce_image_family      = "centos-7"
      compute_image_project = "centos-cloud"
      project_id            = ""
      machine_type     = "e2-medium"
      zone              = "us-central1-b"
      labels = {}
      auto_delete         = true
      kms_key_self_link   = ""
      disk_size           = 30
      disk_type           = "pd-standard" 
      subnetwork_project  = ""        
      subnetwork          = "vpc-google-us-central1-sub"
      external_ip       = ["false"]
      additional_networks = [{}]
      service_account = {
        email  = ""
        scopes = ["cloud-platform"]
      }
      tags                = []   
      metadata              = {}        
      startup_script       = "./modules/create-vm/init.sh"    
      description       = "Linux nat server for vertexIA"
      can_ip_forward   = true
      allow_stopping_for_update = false      
      additional_disks = []      
  },

}
