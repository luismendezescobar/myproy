project_id="playground-s-11-2d89e84c"  #update the project here
vpc_name="webappnet"
region="us-east1"
subnet_name="test-subnetwork"
ip_cidr_range="10.0.0.0/24"

server_dc = {
  dc01={    
    network_ip        = "10.0.0.12"
    zone              = "us-east1-b"    
    instance_type     = "e2-medium"
    source_image      = "windows-cloud/windows-2019"
    boot_disk_size_gb = 70
    boot_disk_type    = "pd-standard"         
    auto_delete       = true
    description       = "Domain controller Instance"
    init_script       = "./modules/create-dc/dc01.ps1" 
    metadata = {
      domain      = "example.net"
      windows-startup-script-url ="gs://storage-3-19-2022-03/dc01.ps1"   
    } 
    instance_tags = ["wsfc"]
    additional_disks = []
  },
}

server_vm_info = {
  node-1={    
    network_ip        = "10.0.0.10"
    zone              = "us-east1-b"    
    #instance_type     = "e2-medium"
    instance_type     = "e2-standard-2"
    source_image      = "windows-cloud/windows-2019"
    boot_disk_size_gb = 70
    boot_disk_type    = "pd-ssd"
    auto_delete       = true
    description       = "sql node-1"
    init_script       = "./modules/create-vm-windows/specialize-node.ps1"  
    metadata = {
      domain      = "example.net"
      enable-wsfc = true
      windows-startup-script-url ="gs://storage-3-19-2022-03/specialize-node.ps1" 
    }
    instance_tags     = ["wsfc","wsfc-node"]
    additional_disks = [  
      {
        disk_size_gb = 20
        disk_type    = "pd-ssd"
        name         = "node-1-sql-data1"
      },
      {
        disk_size_gb = 20
        disk_type    = "pd-ssd"
        name         = "node-1-sql-data2"
      },
      {
        disk_size_gb = 20
        disk_type    = "pd-ssd"
        name         = "node-1-sql-data3"
      },
      {
        disk_size_gb = 20
        disk_type    = "pd-ssd"
        name         = "node-1-sql-data4"
      },
    ]
  },
  node-2={    
    network_ip        = "10.0.0.11"
    zone              = "us-east1-c"    
    #instance_type     = "e2-medium"
    instance_type     = "e2-standard-2"
    source_image      = "windows-cloud/windows-2019"
    boot_disk_size_gb = 70
    boot_disk_type    = "pd-ssd"
    auto_delete       = true
    description       = "sql node-2"
    init_script       = "./modules/create-vm-windows/specialize-node.ps1"  
    metadata = {
      domain      = "example.net"
      enable-wsfc = true
      windows-startup-script-url ="gs://storage-3-19-2022-03/specialize-node.ps1" 
    }
    instance_tags     = ["wsfc","wsfc-node"]
    additional_disks = [  
      {
        disk_size_gb = 20
        disk_type    = "pd-ssd"
        name         = "node-2-sql-data1"
      },
      {
        disk_size_gb = 20
        disk_type    = "pd-ssd"
        name         = "node-2-sql-data2"
      },
      {
        disk_size_gb = 20
        disk_type    = "pd-ssd"
        name         = "node-2-sql-data3"
      },
      {
        disk_size_gb = 20
        disk_type    = "pd-ssd"
        name         = "node-2-sql-data4"
      },
    ]
  },
  witness={    
    network_ip        = "10.0.0.13"
    zone              = "us-east1-c"    
    instance_type     = "e2-standard-2"
    source_image      = "windows-cloud/windows-2019"
    boot_disk_size_gb = 50
    boot_disk_type    = "pd-standard"         
    auto_delete       = true
    description       = "file witness Instance"
    init_script       = "./modules/create-vm-windows/witness-node.ps1"  
    metadata = {
      domain      = "example.net"
      windows-startup-script-url ="gs://storage-3-19-2022-03/witness-node.ps1"           
    } 
    instance_tags = ["wsfc"]
    additional_disks = []
  },

}


internal_ips={
  ip01={
    name="load-balancer"
  },
  ip02={
    name="wsfc-cluster"
  }, 
}


