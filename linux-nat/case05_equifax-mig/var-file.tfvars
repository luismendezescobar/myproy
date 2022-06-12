project_id         ="ta-cse-rd1-dev-npe-d026"  #update the project here
tf_service_account ="tf-ta-cse-rd1-dev-npe@ta-cse-rd1-dev-npe-d026.iam.gserviceaccount.com"
//also add the project account on line 527

/*
gcloud compute images list

PROJECT: centos-cloud
FAMILY: centos-7

PROJECT: centos-cloud
FAMILY: centos-stream-8
*/
/*
instance_template_map = {
  "nat-server" = {
    name_prefix       = "nat-server"
    zone              = "us-east1-b"
    region            = "us-east1"
    machine_type      = "e2-medium"
    source_image      = "centos-stream-9"
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
      email  = "960632049081-compute@developer.gserviceaccount.com"
      scopes = ["cloud-platform"]
    }
    
  },
}


mig_map = {
  "mig-nat" = {
    hostname                  = "mig-nat"
    region                    ="us-east1"
    distribution_policy_zones =["us-east1-b","us-east1-c"]
    update_policy =[{
      instance_redistribution_type = "PROACTIVE" #tries to maintain the zon distribution
      max_surge_fixed              = 0
      max_surge_percent            = null
      max_unavailable_fixed        = 2
      max_unavailable_percent      = null
      min_ready_sec                = null
      replacement_method           = "RECREATE"  #will preserver the name
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
*/
server_vm_info = {
  "isolated-client01" = {
      disk_size             = 20
      compute_image_project = "sec-eng-images-prd-5d4d"
      gce_image_family      = "efx-centos-7"
      labels                = {
        cost_center         = "3429"
        division            = "0001"
        cmdb_bus_svc_id     = "asve0048988"
        data_class          = "1"
      }
      machine_type          = "e2-medium"
      project               = "ta-cse-rd1-dev-npe-d026"
      service_account       = {
        email               = "tf-ta-cse-rd1-dev-npe@ta-cse-rd1-dev-npe-d026.iam.gserviceaccount.com"
        scopes              = ["cloud-platform"]
      }
      metadata              = {
        ssh-keys = "lxm"
      }
      startup_script_file    = "./modules/create-vm/init.sh" 
      subnetwork             = "projects/ta-cse-rd1-dev-npe-d026/regions/us-east1/subnetworks/rd1-dev-vpc-1-useast1-subnet1-isolated"
      zone              = "us-east1-b"      
  },
  "gke1-client01" = {
      disk_size             = 20
      compute_image_project = "sec-eng-images-prd-5d4d"
      gce_image_family      = "efx-centos-7"
      labels                = {
        cost_center         = "3429"
        division            = "0001"
        cmdb_bus_svc_id     = "asve0048988"
        data_class          = "1"
      }
      machine_type          = "e2-medium"
      project               = "ta-cse-rd1-dev-npe-d026"
      service_account       = {
        email               = "tf-ta-cse-rd1-dev-npe@ta-cse-rd1-dev-npe-d026.iam.gserviceaccount.com"
        scopes              = ["cloud-platform"]
      }
      metadata              = {
        ssh-keys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC0esof5aGX6fplQar8TnlQDthPSQOfYP0GatUTgEvvhQYv+VKQww4kLqOb7nTff+vMATB8PZSVK1hQdW6jv7TOLteZuq66MsP81JnjefnRrTEND5r0/orzw6TH0kr66t+1Uj9HDAyEsC+nJBYvQ+z8rj0vVt1+QVAUXafP50CCUtbRIMmi64DzeofQUjvNO4F+CNvqRBK0T0XrXnFvJVLZUZ+89iZFj5TMmVo7OMRbBzufLBzgIV2tqN9m+/xlU8NKIs4X1ChTRrHOTYojGzSZizGA9m6Zmrza3zDQsqfqIKnb/QsDalbGkmkSUS/zp/oyxASLCbkRPGt3XiqYbFg9VPdLmIDK9jN1w0Ib9kQ9Z/dhsTg5CYwGF0o/yWK6XO8pwUxTX5x7iQKyVivdBRNTNBDhUmHE7k3rG6rpvgOceDPTQviKswqcx5QWLhE3XxUBnf653RgThSYmFfzXBvqtLXCpKVGeEu6m0OTi1EUM4wEpc6gRQPyPYYSwmg4d+9E= lxm412@USE-UUSDEV-005"
      }
      startup_script_file    = "./modules/create-vm/init.sh" 
      subnetwork             = "projects/efx-gcp-ta-svpc-npe-6c9a/regions/us-east1/subnetworks/ta-cse-rd1-dev-npe-gke1-0"
      zone                   = "us-east1-b"      
  },    
}