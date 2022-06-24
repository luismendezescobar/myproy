project_id="playground-s-11-b6d87469"  #update the project here
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


server_vm_info_two_nics = {
    "nat-server" = {
        zone              = "us-central1-b"
        instance_type     = "e2-medium"
        source_image      = "centos-cloud/centos-7"
        boot_disk_size_gb = 100
        boot_disk_type    = "pd-standard" 
        auto_delete       = true
        subnet_name1       = "vpc-shared-us-central1-sub"
        subnet_name2       = "vpc-local-us-central1-sub"
        description       = "bastion to manage all"
        init_script       = "./modules/nat_init.sh"  
        external_ip       = ["false"]
        can_ip_forward   = true
        network_tags = []
        additional_disks = []
    },
}


server_vm_info = {
  "shared-client01" = {
      zone              = "us-central1-b"
      instance_type     = "e2-medium"
      //gcloud compute images list
      source_image      = "centos-cloud/centos-7"
      boot_disk_size_gb = 100
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
      boot_disk_size_gb = 100
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



}