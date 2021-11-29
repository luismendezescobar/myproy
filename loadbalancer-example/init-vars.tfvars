project_id="playground-s-11-5bc8aa89"  #update the project here
vpc_name="webappnet"
region="us-east1"
subnet_name="test-subnetwork"
ip_cidr_range="10.1.0.0/24"


server_vm_info = [  
  {
    name              = "node-1"
    network_ip        = ""
    zone              = "us-east1-b"        
    instance_type     = "e2-small"
    source_image      = "windows-cloud/windows-2019"
    boot_disk_size_gb = 50
    boot_disk_type    = "pd-ssd"
    auto_delete       = true
    description       = "sql node-1"
    init_script       = "./modules/create-vm-windows/specialize-node.ps1"  
    metadata = {
      domain      = "example-gcp.com"
      enable-wsfc = true
    }
    instance_tags     = ["fw-gcp-hc-all"]
    additional_disks = []
  },
  {
    name              = "node-2"
    network_ip        = ""
    zone              = "us-east1-c"    
    #instance_type     = "e2-medium"
    instance_type     = "e2-small"
    source_image      = "windows-cloud/windows-2019"
    boot_disk_size_gb = 50
    boot_disk_type    = "pd-ssd"
    auto_delete       = true
    description       = "sql node-2"
    init_script       = "./modules/create-vm-windows/specialize-node.ps1"
    metadata = {
      domain      = "example-gcp.com"
      enable-wsfc = true
    }
    instance_tags     = ["fw-gcp-hc-all"]
    additional_disks = []
  }, 

]


internal_ips={
  ip01={
    name="load-balancer"
  },
  ip02={
    name="wsfc-cluster"
  }, 
}


