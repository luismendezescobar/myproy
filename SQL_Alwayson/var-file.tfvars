#you have to create the newtork manually typing create vnet
#az network vnet subnet list --resource-group 1-626a8dd8-playground-sandbox --vnet-name myvpc

server_vm_info = { 
    "server01" = {        
        location                  = "WestUS"                
        #size                     = "Standard_D4s_v3"
        size                      =  "standard_ds1_v2"
        nic_name                  = "nic-production"
        azure_subnet_id           ="/subscriptions/0f39574d-d756-48cf-b622-0e27a6943bd2/resourceGroups/1-626a8dd8-playground-sandbox/providers/Microsoft.Network/virtualNetworks/myvpc/subnets/default"        
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
        nic_name                  = "nic-production"
        azure_subnet_id           ="/subscriptions/0f39574d-d756-48cf-b622-0e27a6943bd2/resourceGroups/1-626a8dd8-playground-sandbox/providers/Microsoft.Network/virtualNetworks/myvpc/subnets/default"        
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

boot_diagnostic_account_name    ="boot_diagnostics_account_01272022"        

subguid                         ="0f39574d-d756-48cf-b622-0e27a6943bd2"          #MMS Shared Services ### this number is inside the resource group properties 
azure_resource_group_name       ="1-626a8dd8-playground-sandbox"


#storage_account_name_for_backend="storage4terra1052021"  #this is for the backend it needs to be created manually
#container_name_for_state        ="statecontainer"                #this is for the backend it needs to be created manually

storage_account_for_boot_diag   ="bootdiag01272022"
storage_container_for_boot_diag ="bootblob"