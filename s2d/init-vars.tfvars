project_id="playground-s-11-6926d02c"  #update the project here
vpc_name="webappnet"
region="us-east1"
subnet_name="test-subnetwork"
ip_cidr_range="10.1.0.0/24"


server_vm_info = [
  {
    name              = "ad-dc1"
    network_ip        = "10.1.0.100"
    zone              = "us-east1-b"    
    instance_type     = "e2-small"
    source_image      = "windows-cloud/windows-2019"
    boot_disk_size_gb = 120
    boot_disk_type    = "pd-standard"         
    auto_delete       = true
    description       = "Domain controller Instance"
    init_script       = "" 
    metadata = {
      domain      = "example-gcp.com"      
    } 
    instance_tags = ["wsfc"]
    additional_disks = []
  },
  {
    name              = "node-1"
    network_ip        = ""
    zone              = "us-east1-b"    
    #instance_type     = "e2-medium"
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
    instance_tags     = ["wsfc","wsfc-node"]
    additional_disks = [  
      {
        disk_size_gb = 10
        disk_type    = "pd-ssd"
        name         = "node-1-sql-data1"
      },
      {
        disk_size_gb = 10
        disk_type    = "pd-ssd"
        name         = "node-1-sql-data2"
      },
      {
        disk_size_gb = 10
        disk_type    = "pd-ssd"
        name         = "node-1-sql-data3"
      },
      {
        disk_size_gb = 10
        disk_type    = "pd-ssd"
        name         = "node-1-sql-data4"
      },
    ]
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
    instance_tags     = ["wsfc","wsfc-node"]
    additional_disks = [  
      {
        disk_size_gb = 10
        disk_type    = "pd-ssd"
        name         = "node-2-sql-data1"
      },
      {
        disk_size_gb = 10
        disk_type    = "pd-ssd"
        name         = "node-2-sql-data2"
      },
      {
        disk_size_gb = 10
        disk_type    = "pd-ssd"
        name         = "node-2-sql-data3"
      },
      {
        disk_size_gb = 10
        disk_type    = "pd-ssd"
        name         = "node-2-sql-data4"
      },
    ]
  },
  {
    name              = "witness"
    network_ip        = ""
    zone              = "us-east1-c"    
    instance_type     = "e2-small"
    source_image      = "windows-cloud/windows-2019"
    boot_disk_size_gb = 50
    boot_disk_type    = "pd-standard"         
    auto_delete       = true
    description       = "file witness Instance"
    init_script       = "./modules/create-vm-windows/witness-node.ps1"  
    metadata = {
      domain      = "example-gcp.com"      
    } 
    instance_tags = ["wsfc"]
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


