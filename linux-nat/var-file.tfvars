project_id="playground-s-11-2a0e15a0"  #update the project here

vpc_info = {
    "vpc-shared"={
        auto_create_subnetworks=false
        subnetworks = [
            {
                subnet_name     = "vpc-shared-us-east1-sub"
                ip_cidr_range   = "10.10.10.0/24" 
                region          =  "us-east1"
            }
        ]
    }
    "vpc-local"={
        auto_create_subnetworks=false
        subnetworks = [
            {
                subnet_name     = "vpc-local-us-east1-sub"
                ip_cidr_range   = "10.10.11.0/24" 
                region          =  "us-east1"
            }
        ]
    }


}


server_vm_info = {
    "bastion01" = {
        zone              = "us-east1-b"
        instance_type     = "e2-medium"
        //gcloud compute images list
        source_image      = "centos-cloud/centos-stream-9"
        boot_disk_size_gb = 100
        boot_disk_type    = "pd-standard" 
        auto_delete       = true
        subnet_name       = "vpc-local-us-east1-sub"
        description       = "bastion to manage all"
        init_script       = "./modules/create-vm/dummy.sh"  
        external_ip       = ["true"]
        can_ip_forward   = false
        network_tags = []
        additional_disks = []
    },
    "client02" = {
        zone              = "us-east1-b"        
        instance_type     = "e2-medium"
        source_image      = "centos-cloud/centos-stream-9"
        boot_disk_size_gb = 100
        boot_disk_type    = "pd-standard" 
        auto_delete       = true
        subnet_name       = "vpc-local-us-east1-sub"
        description       = "client that will access all through the linux router"
        init_script       = "./modules/create-vm/dummy.sh"  
        external_ip       = ["false"]
        can_ip_forward    = false
        network_tags = ["no-ip"]   //rename this to network_tags
        additional_disks = []
    },
    "srvgtw"={
        zone              = "us-east1-b"
        instance_type     = "e2-medium"
        source_image      = "centos-cloud/centos-stream-9"
        boot_disk_size_gb = 100
        boot_disk_type    = "pd-standard" 
        auto_delete       = true
        subnet_name       = "vpc-local-us-east1-sub"
        description       = "Router in linux"
        init_script       = "./modules/create-vm/dummy.sh"   
        external_ip       = ["true"]
        can_ip_forward    = true
        network_tags = []
        additional_disks = []
    },
}