#you have to create the newtork manually typing create vnet
#az network vnet subnet list --resource-group 1-626a8dd8-playground-sandbox --vnet-name myvpc

server_vm_info = { 
    "server01" = {        
        location                  = "WestUS"                
        #size                     = "Standard_D4s_v3"
        size                      =  "standard_ds1_v2"
        nic_name                  = "nic-production01"
        azure_subnet_id           ="/subscriptions/0f39574d-d756-48cf-b622-0e27a6943bd2/resourceGroups/1-d13a137b-playground-sandbox/providers/Microsoft.Network/virtualNetworks/myvpc/subnets/default"
        private_ip_address_allocation = "Static"
        static_ip                 = "10.10.10.10"
        admin_username            = "localvmadmin"
        admin_password            = "Passw0rd12345!"        
        disk_size_gb              = 127
        caching_type              = "ReadWrite"
        storage_account_type      = "Standard_LRS"        
        source_image_id           = "/subscriptions/bf8f2b46-7581-485d-a21e-9ecfc670b79e/resourceGroups/rg-Core-SIG/providers/Microsoft.Compute/galleries/CoreSigProd/images/Windows-2019-CIS/versions/2021.09.15"
        enable_automatic_updates  = "false"
        patch_mode                = "Manual"        
        custom_data               = "./files/bywus-web-trn3.ps1"

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
        location                  = "WestUS"                
        #size                     = "Standard_D4s_v3"
        size                      = "standard_ds1_v2"
        nic_name                  = "nic-production02"
        azure_subnet_id           ="/subscriptions/0f39574d-d756-48cf-b622-0e27a6943bd2/resourceGroups/1-d13a137b-playground-sandbox/providers/Microsoft.Network/virtualNetworks/myvpc/subnets/default"
        private_ip_address_allocation = "Static"
        static_ip                 = "10.10.10.11"
        admin_username            = "localvmadmin"
        admin_password            = "Passw0rd12345!"        
        disk_size_gb              = 127
        caching_type              = "ReadWrite"
        storage_account_type      = "Standard_LRS"        
        source_image_id           = "/subscriptions/bf8f2b46-7581-485d-a21e-9ecfc670b79e/resourceGroups/rg-Core-SIG/providers/Microsoft.Compute/galleries/CoreSigProd/images/Windows-2019-CIS/versions/2021.09.15"
        enable_automatic_updates  = "false"
        patch_mode                = "Manual"        
        custom_data               = "./files/bywus-web-trn3.ps1"

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
lb_location= "WestUS"                
lb_azure_subnet_id="/subscriptions/0f39574d-d756-48cf-b622-0e27a6943bd2/resourceGroups/1-d13a137b-playground-sandbox/providers/Microsoft.Network/virtualNetworks/myvpc/subnets/default"
lb-backendpool-name="lb_bep_sql01"
lb_probe_ntc="lb_probe_ntc_sql01"
lb_probe_sql="lb_probe_sql_sql01"
lb_rule_ntc ="lb_rule_ntc_sql01"
lb_rule_sql ="lb_rule_sql_sql01"
avset_name  ="avset_name_sql01"

########################dynamic variables##############################

boot_diagnostic_account_name    ="boot_diagnostics_account_01292022"        

subguid                         ="0f39574d-d756-48cf-b622-0e27a6943bd2"          #MMS Shared Services ### this number is inside the resource group properties 
azure_resource_group_name       ="1-d13a137b-playground-sandbox"




storage_account_for_boot_diag   ="bootdiag01292022"
storage_container_for_boot_diag ="bootblob"