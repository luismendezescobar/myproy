project_id="playground-s-11-0ab8726"  #update the project here
vpc_name="webappnet"
region="us-east1"
subnet_name="test-subnetwork"
ip_cidr_range="10.10.10.0/24"


server_vm_info = {
    "bastion01" = {
        zone              = "us-east1-b"
        instance_type     = "e2-medium"
        //gcloud compute images list
        source_image      = "centos-cloud/centos-stream-9"
        boot_disk_size_gb = 100
        boot_disk_type    = "pd-standard" 
        auto_delete       = true
        subnet_name       = "test-subnetwork"
        description       = "bastion to manage all"
        init_script       = "./modules/create-vm/dummy.sh"  
        external_ip       = ["true"]
        instance_tags = []
        additional_disks = []
    },
    "client01" = {
        zone              = "us-east1-b"        
        instance_type     = "e2-medium"
        source_image      = "centos-cloud/centos-stream-9"
        boot_disk_size_gb = 100
        boot_disk_type    = "pd-standard" 
        auto_delete       = true
        subnet_name       ="test-subnetwork"
        description       = "client that will access all through the linux router"
        init_script       = "./modules/create-vm/dummy.sh"  
        external_ip       = ["false"]
        instance_tags = []
        additional_disks = []
    },
    "srv_gtw"={
        zone              = "us-east1-b"
        instance_type     = "e2-medium"
        source_image      = "centos-cloud/centos-stream-9"
        boot_disk_size_gb = 100
        boot_disk_type    = "pd-standard" 
        auto_delete       = true
        subnet_name       = "test-subnetwork"
        description       = "Router in linux"
        init_script       = "./modules/create-vm/dummy.sh"   
        external_ip       = ["true"]
        instance_tags = []
        additional_disks = []
    },
}