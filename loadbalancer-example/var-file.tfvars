project_id="playground-s-11-cf64a209"  #update the project here
vpc_name="webappnet"
region="us-east1"
subnet_name="test-subnetwork"
ip_cidr_range="10.1.0.0/24"


server_vm_info = [  
  {
    name              = "node-1"
    network_ip        = ""
    zone              = "us-east1-b"        
    instance_type     = "e2-medium"
    source_image      = "windows-cloud/windows-2019"
    boot_disk_size_gb = 50
    boot_disk_type    = "pd-ssd"
    auto_delete       = true
    description       = "sql node-1"
    init_script       = "./modules/create-vm-windows/scripts/specialize-node.ps1"  
    loadbalancer       = "serviceweb"


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
    zone              = "us-east1-b"        
    instance_type     = "e2-medium"
    source_image      = "windows-cloud/windows-2019"
    boot_disk_size_gb = 50
    boot_disk_type    = "pd-ssd"
    auto_delete       = true
    description       = "sql node-1"
    init_script       = "./modules/create-vm-windows/scripts/specialize-node.ps1"  
    loadbalancer       = ""


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

named_port= [
    {
      name = "http"
      port = "80"
    }
]

health_check={
    type                = "tcp"
    port                = 80
    healthy_threshold   = 2
    unhealthy_threshold = 2
    check_interval_sec  = 5
    timeout_sec         = 3
    port_specification  = "USE_FIXED_PORT"
    initial_delay_sec   = 600
}
frontend_ports =[]
frontend_name = "forwarding-rule"
