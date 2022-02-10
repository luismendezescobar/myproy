##change these when deploying
azure_resource_group_name="1-c805ffc1-playground-sandbox"
#azure_subnet_id          ="/subscriptions/3258efe1-d8e7-4e11-aa41-7ece0bcd7d88/resourceGroups/rg-west-ETS_NETWORK/providers/Microsoft.Network/virtualNetworks/vnet-west-MMS-SharedServices/subnets/MMS-Development"
# you can get it with this command az network vnet subnet list
azure_subnet_id           ="/subscriptions/4cedc5dd-e3ad-468d-bf66-32e31bdb9148/resourceGroups/1-c805ffc1-playground-sandbox/providers/Microsoft.Network/virtualNetworks/myvpc/subnets/default"
bootdiags_primary_blob_endpoint="https://mystorage11722.blob.core.windows.net/mycontainer1172022"
azure_location= "West US"   
region="WUS"
subguid="4cedc5dd-e3ad-468d-bf66-32e31bdb9148"  #this number is inside the resource group properties 
#######################################################################################################
appabbrev="server"
#core_image_reference=
resource_tags = {
    core-app-name   = "Blue Yonder"
    core-app-owner  = "Darren.Heguy@mckesson.com"
    core-data-owner = "Darren.Heguy@mckesson.com"
    core-env        = "training"        
    core-tech-owner = "s4735vt-michael.malake@cypressmed.com"
    CostCenter      = "n/a"
    Core-bap-number = "AS22490"
}

#shared_services_data={}
local_vm_adminusername="localvmadmin"
local_vm_password="Passw0rd12345!" 
vm_timezone="Central Standard Time"

node_count= 2
  
node_size="standard_ds1_v2"

sql_data_disk_size_gb=10
sql_data_disk_count=2
sql_logs_disk_size_gb=10
sql_logs_disk_count=2 
sql_tempdb_disk_size_gb=10
sql_tempdb_disk_count=2
  