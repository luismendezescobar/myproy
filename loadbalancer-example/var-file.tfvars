project_id="playground-s-11-41463d5b"  #update the project here
vpc_name="webappnet"
region="us-east1"
subnet_name="test-subnetwork"
ip_cidr_range="10.1.0.0/24"


server_vm_info = [  
  {
    name              = "node-1"
    network_ip        = ""
    zone              = "us-east1-b"        
    instance_type     = "custom-4-4096"
    source_image      = "windows-cloud/windows-2019"
    boot_disk_size_gb = 50
    boot_disk_type    = "pd-ssd"
    auto_delete       = true
    description       = "sql node-1"
    init_script       = ""  
    loadbalancer       = "serviceweb"


    metadata = {
      sysprep-specialize-script-ps1  = "./modules/create-vm-windows/scripts/specialize-node.ps1"  
    }
    instance_tags     = []
    additional_disks = []
  },
  {
    name              = "node-2"
    network_ip        = ""
    zone              = "us-east1-b"        
    instance_type     = "custom-4-4096"
    source_image      = "windows-cloud/windows-2019"
    boot_disk_size_gb = 50
    boot_disk_type    = "pd-ssd"
    auto_delete       = true
    description       = "sql node-1"
    init_script       = ""  
    loadbalancer       = "serviceweb"

    metadata = {
      sysprep-specialize-script-ps1  = "./modules/create-vm-windows/scripts/specialize-node.ps1"  
    }
    instance_tags     = []
    additional_disks = []
  },
  
]

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
    timeout_sec         = 5
    port_specification  = "USE_FIXED_PORT"
    initial_delay_sec   = 600
}
frontend_ports =[]
frontend_name = "forwarding-rule"
