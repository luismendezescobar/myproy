project_id="playground-s-11-1934f5ac"  #update the project here
vpc_name="webappnet"
region="us-east1"
subnet_name="test-subnetwork"
ip_cidr_range="10.1.1.0/24"


server_vm_info = [
  {
    name              = "ad-dc1"
    zone              = "us-east1-b"    
    instance_type     = "e2-small"
    source_image      = "windows-cloud/windows-2019"
    boot_disk_size_gb = 120
    boot_disk_type    = "pd-standard" 
    auto_delete       = true
    description       = "Domain controller Instance"
    init_script       = ""  
    instance_tags = ["wsfc"]
    additional_disks = []
  },
]