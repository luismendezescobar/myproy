project_id="playground-s-11-a9415942"  #update the project here

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
    "vpc-spoke"={
        auto_create_subnetworks=false
        subnetworks = [
            {
                subnet_name     = "vpc-spoke-us-east1-sub"
                ip_cidr_range   = "10.10.12.0/24" 
                region          =  "us-east1"
            }
        ]
    }
}


server_vm_info = {
    "shared-client01" = {
        zone              = "us-east1-b"
        instance_type     = "e2-medium"
        //gcloud compute images list
        source_image      = "centos-cloud/centos-stream-9"
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
        source_image      = "centos-cloud/centos-stream-9"
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
    "spoke" = {
        zone              = "us-east1-b"        
        instance_type     = "e2-medium"
        source_image      = "centos-cloud/centos-stream-9"
        boot_disk_size_gb = 100
        boot_disk_type    = "pd-standard" 
        auto_delete       = true
        subnet_name       = "vpc-spoke-us-east1-sub"
        description       = "client that will access all through the network peering"
        init_script       = "./modules/create-vm/init.sh"  
        external_ip       = ["false"]
        can_ip_forward    = false
        network_tags = ["no-ip"]   
        additional_disks = []
    },

/*    "shared-client02" = {
        zone              = "us-east1-b"        
        instance_type     = "e2-medium"
        source_image      = "centos-cloud/centos-stream-9"
        boot_disk_size_gb = 100
        boot_disk_type    = "pd-standard" 
        auto_delete       = true
        subnet_name       = "vpc-shared-us-east1-sub"
        description       = "client that will access all through the linux router"
        init_script       = "./modules/create-vm/dummy.sh"  
        external_ip       = ["false"]
        can_ip_forward    = false
        network_tags = ["no-ip"]   
        additional_disks = []
    },
    "local-client02" = {
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
        network_tags = ["no-ip"]   
        additional_disks = []
    },
*/
}

#########here begins all the variables for the load balancer
lb_mig_nat_var = {
    "lb-nat-server" = {
        zone              = "us-east1-b"
        region            = "us-east1"
        instance_type     = "e2-medium"
        source_image      = "centos-cloud/centos-stream-9"
        boot_disk_size_gb = 100
        boot_disk_type    = "pd-standard" 
        auto_delete       = true
        subnet_name1      = "vpc-shared-us-east1-sub"
        subnet_name2      = "vpc-local-us-east1-sub"
        description       = "bastion to manage all"
        init_script       = "./modules/lb-mig/nat_init.sh"  
        external_ip       = ["false"]
        can_ip_forward   = true
        network_tags = []  
       
    },
}

health_check = {
        name                = "health-check-lb-nat"
        check_interval_sec  = 5
        timeout_sec         = 5
        healthy_threshold   = 2
        unhealthy_threshold = 10
        type                = "tcp"
        port                = 22
        
}
mig_info = {
    name               = "nat-managed-instance-group"
    base_instance_name = "nat-servers"
    target_size        = 2  
    initial_delay_sec  = 300            
}
mig_zones =["us-east1-b"]

load_balancer_info01 = {
    lb_name               = "lb-backend-shared"
    protocol              = "TCP"
    load_balancing_scheme = "INTERNAL" 
    session_affinity      = "CLIENT_IP"
    balancing_mode        = "CONNECTION"
    vpc                   = "vpc-shared"
    forwarding_name       = "forwarding-rule-shared"   
    ip_protocol           = "TCP"
    load_balancing_scheme = "INTERNAL"
    all_ports             = true
    allow_global_access   = false
    network               = "vpc-shared"
    subnetwork            = "vpc-shared-us-east1-sub"
}
load_balancer_info02 = {
    lb_name               = "lb-backend-local"
    protocol              = "TCP"
    load_balancing_scheme = "INTERNAL" 
    session_affinity      = "CLIENT_IP"
    balancing_mode        = "CONNECTION"
    vpc                   = "vpc-local"
    forwarding_name       = "forwarding-rule-local"   
    ip_protocol           = "TCP"
    load_balancing_scheme = "INTERNAL"
    all_ports             = true
    allow_global_access   = false
    network               = "vpc-local"
    subnetwork            = "vpc-local-us-east1-sub"            
}
