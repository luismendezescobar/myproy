#you have to create the newtork manually typing create vnet
#az network vnet create --name myvpc --resource-group 1-0e84c6ac-playground-sandbox --subnet-name default --location "Central US"
#az network vnet subnet list --resource-group 1-0e84c6ac-playground-sandbox --vnet-name myvpc 

server_vm_info = { 
    "server01" = {        
        location                  = "Central US"                
        #size                     = "Standard_D4s_v3"
        size                      =  "standard_ds1_v2"
        nic_name                  = "nic-production01"
        azure_subnet_id           = "/subscriptions/0f39574d-d756-48cf-b622-0e27a6943bd2/resourceGroups/1-0e84c6ac-playground-sandbox/providers/Microsoft.Network/virtualNetworks/myvpc/subnets/default"
        private_ip_address_allocation = "Static"
        static_ip                 = "10.0.0.10"
        admin_username            = "localvmadmin"
        admin_password            = "Passw0rd12345!"        
        disk_size_gb              = 127
        caching_type              = "ReadWrite"
        storage_account_type      = "Standard_LRS"        
        source_image_id           = "/subscriptions/bf8f2b46-7581-485d-a21e-9ecfc670b79e/resourceGroups/rg-Core-SIG/providers/Microsoft.Compute/galleries/CoreSigProd/images/Windows-2019-CIS/versions/2021.09.15"
        enable_automatic_updates  = "false"
        patch_mode                = "Manual"        
        custom_data               = "./files/server01.txt"

        additional_disks = [{
            name                    ="drivef"
            disk_size_gb            = 10
            storage_account_type    = "Premium_LRS"
            create_option           = "Empty"
            caching                 = "ReadWrite"
            lun_number              = 10                  
            },
        ]
    },
    "server02" = {        
        location                  = "Central US"                
        #size                     = "Standard_D4s_v3"
        size                      = "standard_ds1_v2"
        nic_name                  = "nic-production02"
        azure_subnet_id           = "/subscriptions/0f39574d-d756-48cf-b622-0e27a6943bd2/resourceGroups/1-0e84c6ac-playground-sandbox/providers/Microsoft.Network/virtualNetworks/myvpc/subnets/default"
        private_ip_address_allocation = "Static"
        static_ip                 = "10.0.0.11"
        admin_username            = "localvmadmin"
        admin_password            = "Passw0rd12345!"        
        disk_size_gb              = 127
        caching_type              = "ReadWrite"
        storage_account_type      = "Standard_LRS"        
        source_image_id           = "/subscriptions/bf8f2b46-7581-485d-a21e-9ecfc670b79e/resourceGroups/rg-Core-SIG/providers/Microsoft.Compute/galleries/CoreSigProd/images/Windows-2019-CIS/versions/2021.09.15"
        enable_automatic_updates  = "false"
        patch_mode                = "Manual"        
        custom_data               = "./files/server01.txt"

        additional_disks = [{
            name                    ="drivef"
            disk_size_gb            = 10
            storage_account_type    = "Premium_LRS"
            create_option           = "Empty"
            caching                 = "ReadWrite"
            lun_number              = 10            
        },    
        ]       
    },   
}

server_vm_info_additional = { 
    "dc01" = {        
        location                  = "Central US"                
        #size                     = "Standard_D4s_v3"
        size                      =  "standard_ds1_v2"
        nic_name                  = "nic-production01"
        azure_subnet_id           = "/subscriptions/0f39574d-d756-48cf-b622-0e27a6943bd2/resourceGroups/1-0e84c6ac-playground-sandbox/providers/Microsoft.Network/virtualNetworks/myvpc/subnets/default"
        private_ip_address_allocation = "Static"
        static_ip                 = "10.0.0.12"
        admin_username            = "localvmadmin"
        admin_password            = "Passw0rd12345!"        
        disk_size_gb              = 127
        caching_type              = "ReadWrite"
        storage_account_type      = "Standard_LRS"        
        source_image_id           = "/subscriptions/bf8f2b46-7581-485d-a21e-9ecfc670b79e/resourceGroups/rg-Core-SIG/providers/Microsoft.Compute/galleries/CoreSigProd/images/Windows-2019-CIS/versions/2021.09.15"
        enable_automatic_updates  = "false"
        patch_mode                = "Manual"        
        custom_data               = "./files/dc01.txt"

        additional_disks = []
    },
}

/*
server_vm_info_external = { 
    "bastion" = {        
        location                  = "Central US"                
        #size                     = "Standard_D4s_v3"
        size                      =  "standard_ds1_v2"
        nic_name                  = "nic-production01"
        azure_subnet_id           = "/subscriptions/964df7ca-3ba4-48b6-a695-1ed9db5723f8/resourceGroups/1-f79bd4b5-playground-sandbox/providers/Microsoft.Network/virtualNetworks/myvpc/subnets/default"
        private_ip_address_allocation = "Static"
        static_ip                 = "10.0.0.13"
        admin_username            = "localvmadmin"
        admin_password            = "Passw0rd12345!"        
        disk_size_gb              = 127
        caching_type              = "ReadWrite"
        storage_account_type      = "Standard_LRS"        
        source_image_id           = "/subscriptions/bf8f2b46-7581-485d-a21e-9ecfc670b79e/resourceGroups/rg-Core-SIG/providers/Microsoft.Compute/galleries/CoreSigProd/images/Windows-2019-CIS/versions/2021.09.15"
        enable_automatic_updates  = "false"
        patch_mode                = "Manual"        
        custom_data               = "./files/bywus-web-trn3.ps1"

        additional_disks = []
    },
}
*/




server_vm_info_linux = {}

resource_tags                   = {
    core-app-name   = "Blue Yonder"
    core-app-owner  = "Darren.Heguy@mckesson.com"
    core-data-owner = "Darren.Heguy@mckesson.com"
    core-env        = "training"        
    core-tech-owner = "s4735vt-michael.malake@cypressmed.com"
    CostCenter      = "n/a"
    Core-bap-number = "AS22490"
}

####################load balancer variables#########
lb_name="lb_sql01"
lb_location= "Central US"                
lb_azure_subnet_id="/subscriptions/0f39574d-d756-48cf-b622-0e27a6943bd2/resourceGroups/1-0e84c6ac-playground-sandbox/providers/Microsoft.Network/virtualNetworks/myvpc/subnets/default"
lb-backendpool-name="lb_bep_sql01"
lb_probe_ntc="lb_probe_ntc_sql01"
lb_probe_sql="lb_probe_sql_sql01"
lb_rule_ntc ="lb_rule_ntc_sql01"
lb_rule_sql ="lb_rule_sql_sql01"
avset_name  ="avset_name_sql01"

cluster_front_end_ip= "10.0.0.14"    ##the ip of the cluster_front_end must be the same as the one used in the wsfcm (inside windows)
sql_front_end_ip= "10.0.0.15"        ##this has to be a new one, that one later on will be used for the AG listener


########################dynamic variables##############################


subguid                         ="0f39574d-d756-48cf-b622-0e27a6943bd2"          #MMS Shared Services ### this number is inside the resource group properties 
azure_resource_group_name       ="1-0e84c6ac-playground-sandbox"


storage_account_for_boot_diag   ="bootdiag02072022"
storage_container_for_boot_diag ="bootblob"

storage_account_for_witness="witness272022"