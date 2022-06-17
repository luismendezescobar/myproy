
/*
gcloud compute images list

PROJECT: centos-cloud
FAMILY: centos-7

PROJECT: centos-cloud
FAMILY: centos-stream-8
*/

instance_template_map = {
  "projectx-nat-server" = {
    project_id        = "project_id"
    name_prefix       = "nat-server"
    zone              = "us-east1-b"
    region            = "us-east1"
    machine_type      = "e2-medium"
    source_image      = "centos-stream-8"
    source_image_family="centos-stream-8"
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
      access_config  = []        
    }]
    //this part will be initalized in the top
    service_account={
      email  = ""
      scopes = ["cloud-platform"]
    }
    
  },
}

/*
mig_map = {
  "mig-nat" = {
    hostname                  = "mig-nat"
    region                    ="us-east1"
    distribution_policy_zones =["us-east1-b","us-east1-c"]
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
  "lb-backend-shared" ={    
    region                = "us-east1"
    protocol              = "TCP"
    load_balancing_scheme = "INTERNAL" 
    session_affinity      = "CLIENT_IP"
    balancing_mode        = "CONNECTION"
    vpc                   = "vpc-shared"
    forwarding_name       = "forwarding-rule-shared"   
    ip_protocol           = "TCP"    
    all_ports             = true
    allow_global_access   = false
    network               = "vpc-shared"
    subnetwork            = "vpc-shared-us-east1-sub"
  },
  "lb-backend-local" = {
    region                = "us-east1"
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
    subnetwork            = "vpc-local-us-east1-sub"            
  }
}

server_vm_info = {
  "shared-client01" = {
      zone              = "us-east1-b"
      instance_type     = "e2-medium"
      //gcloud compute images list
      source_image      = "centos-cloud/centos-7"
      boot_disk_size_gb = 100
      boot_disk_type    = "pd-standard" 
      auto_delete       = true
      subnet_name       = "vpc-shared-us-east1-sub"
      description       = "bastion to manage all"
      init_script       = "./modules/create-vm/init.sh"  
      external_ip       = ["false"]
      can_ip_forward   = false
      network_tags = ["no-ip"]
      additional_disks = []
  },
  "local-client01" = {
      zone              = "us-east1-b"
      instance_type     = "e2-medium"
      //gcloud compute images list
      #source_image      = "efx-centos-7/efx-centos7"
      source_image      = "centos-cloud/centos-7"
      boot_disk_size_gb = 100
      boot_disk_type    = "pd-standard" 
      auto_delete       = true
      subnet_name       = "vpc-local-us-east1-sub"
      description       = "bastion to manage all"
      init_script       = "./modules/create-vm/init.sh"  
      external_ip       = ["false"]
      can_ip_forward   = false
      network_tags = ["no-ip"]
      additional_disks = []
  },    
}
*/