#you have to create the newtork manually typing create vnet
#az network vnet create --name myvpc --resource-group 1-0e84c6ac-playground-sandbox --subnet-name default --location "Central US"
#az network vnet subnet list --resource-group 1-0e84c6ac-playground-sandbox --vnet-name myvpc 

server_vm_info_linux = {
    "server-ansible02" = {
        location                  = "WestUS"        
        size                      = "Standard_DS1_v2"
        nic_name                  = "nic-production"
        azure_subnet_id           ="/subscriptions/964df7ca-3ba4-48b6-a695-1ed9db5723f8/resourceGroups/1-93db68cb-playground-sandbox/providers/Microsoft.Network/virtualNetworks/1-93db68cb-playground-sandbox-vnet/subnets/default"
        private_ip_address_allocation = "Dynamic"
        admin_username            = "luis10"
        admin_password            = "Passw0rd12345!"        
        disk_size_gb              = 127
        caching_type              = "ReadWrite"
        storage_account_type      = "Standard_LRS"        
        source_image_id           = "/subscriptions/bf8f2b46-7581-485d-a21e-9ecfc670b79e/resourceGroups/rg-Core-SIG/providers/Microsoft.Compute/galleries/CoreSigProd/images/CentOS-8-CIS/versions/2021.05.15"
        enable_automatic_updates  = "false"
        patch_mode                = "Manual"        
        join_domain               = "true"

        additional_disks = [{
            name                    ="data-disk"
            disk_size_gb            = 10
            storage_account_type    = "Premium_LRS"
            create_option           = "Empty"
            caching                 = "ReadWrite"
            lun_number              = 10            
        },        ]
    }
}



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
lb_name="lbbydb01_app"
lb_location= "West US"              
lb_azure_subnet_id="/subscriptions/3258efe1-d8e7-4e11-aa41-7ece0bcd7d88/resourceGroups/rg-west-ETS_NETWORK/providers/Microsoft.Network/virtualNetworks/vnet-west-MMS-SharedServices/subnets/sb-blueyonderuat-app"
lb-backendpool-name="lbbydb01_bep_app01"
lb_probe_ntc="lbbydb01_probe_ntc_app01"
#lb_probe_sql="lbbydb01_probe_sql_sql01"
lb_rule_ntc ="lbbydb01_rule_app"
#lb_rule_sql ="lbbydb01_rule_sql_sql01"
avset_name  ="lbbydb01_avset_name_app01"

cluster_front_end_ip= "10.15.128.54"    ##the ip of the cluster_front_end must be the same as the one used in the wsfcm (inside windows)



########################dynamic variables##############################


subguid                         ="964df7ca-3ba4-48b6-a695-1ed9db5723f8"          #MMS Shared Services ### this number is inside the resource group properties 
azure_resource_group_name       ="1-93db68cb-playground-sandbox"


storage_account_for_boot_diag   ="mystorage1kchrcu6gu"
storage_container_for_boot_diag ="statecontainer"

storage_account_for_witness="witness2102022app"              #we are going to leave the witness account, I'm not sure if will be used.
