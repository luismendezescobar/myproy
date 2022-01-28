#01.first create the storage account for boot diagnostics
/*
resource "azurerm_storage_account" "dev_boot_diag" {
  name                     = "testluis09032021"
  resource_group_name      = var.resource_group_name
  location                 = var.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags={
        environment="Terraform Storage"
        CreatedBy= "Luis Mendez"
    }
}
resource "azurerm_storage_container" "lab" {
  name                  = "bootblob"
  storage_account_name  = azurerm_storage_account.dev_boot_diag.name
  container_access_type = "private"
}
*/
#this is the one that we want
#"https://testluis09032021.blob.core.windows.net"
/*
output "bloburl" {
  value = azurerm_storage_account.lab.primary_blob_endpoint
}
*/

#02.second we are going to create the network cards for the machines 
resource "azurerm_network_interface" "server_dev_nic" {
  
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.nic_name
    subnet_id                     = var.azure_subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    private_ip_address_version    = "IPv4"
    primary                       = true
  }
  tags                          = var.resource_tags
}

#03.next step, create the vm

resource "azurerm_linux_virtual_machine" "server_ansible" {
  name                        = var.server_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  size                        = var.size
  network_interface_ids       = [azurerm_network_interface.server_dev_nic.id]  
  tags                        = var.resource_tags
  admin_username              = var.admin_username
  admin_password              = var.admin_password
  disable_password_authentication =false

  admin_ssh_key {
    username                  = var.admin_username
    public_key                = var.public_key
  }


  os_disk {
    name                      = join("-", [lower(var.server_name), "os"])
    caching                   = var.caching_type
    storage_account_type      = var.storage_account_type
    disk_size_gb              = var.disk_size_gb
  }
  source_image_id             = var.source_image_id
  
    

# Uncomment for PROD 
 boot_diagnostics {  
    storage_account_uri       = var.primary_blob_endpoint
    
 }
}


locals {
  vm_disks = {
    for i in var.additional_disks : i.name => i
  }
}


resource "azurerm_managed_disk" "azure_machine_disks" {
    for_each               = local.vm_disks
    name                   = join("-", [lower(var.server_name), each.value.name])
    location               = var.location
    resource_group_name    = var.resource_group_name
    storage_account_type   = each.value.storage_account_type
    create_option          = each.value.create_option
    disk_size_gb           = each.value.disk_size_gb
    tags                   = var.resource_tags    
}

resource "azurerm_virtual_machine_data_disk_attachment" "azure_disk_attach" {
    for_each               = local.vm_disks
    managed_disk_id        = lookup(azurerm_managed_disk.azure_machine_disks[each.value.name], "id", null)
    virtual_machine_id     = azurerm_linux_virtual_machine.server_ansible.id
    caching                = each.value.caching
    lun                    = each.value.lun_number    
}




/*
resource "azurerm_template_deployment" "join-server" {
  
  name                = join("-", [lower(var.server_name), "joinad-template"])
  resource_group_name = var.resource_group_name

  template_body = <<DEPLOY
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "vmList": {
            "type": "string",
            "minLength": 1,
            "metadata": {
                "description": "List of virtual machines to be domain joined, if using multiple VMs, make their names comma separate. E.g. VM01, VM02, VM03."
            }
        },
        "domainFQDN": {
            "type": "string",
            "defaultValue": "na.corp.mckesson.com",
            "metadata": {
                "description": "Domain FQDN where the virtual machine will be joined"
            }
        },
        "ouPath": {
            "type": "string",
            "defaultValue": "OU=AZ,OU=DM,OU=Delegated,DC=na,DC=corp,DC=mckesson,DC=com",
            "metadata": {
                "description": "Specifies an organizational unit (OU) for the domain account. Enter the full distinguished name of the OU in quotation marks. Example: OU=testOU; DC=domain; DC=Domain; DC=com"
            }
        }
    },
    "variables": {
        "domainJoinOptions": "3",
        "domainToJoin": "na.corp.mckesson.com",
        "ouPath": "OU=AZ,OU=DM,OU=Delegated,DC=na,DC=corp,DC=mckesson,DC=com",
        "keyVaultRef": "/subscriptions/bf8f2b46-7581-485d-a21e-9ecfc670b79e/resourceGroups/zcontainerd/providers/Microsoft.KeyVault/vaults/dmjoin-kv",
        "domainusername": "dcay7pp",
        "domainpassword": "dcay7pppass",
        "vmListArray": "[split(parameters('vmList'),',')]",
        "templatelink": "https://mckcore.blob.core.windows.net/agents/JoinADDomain/JoinADDomain/domainjoinbackend.json?sp=r&st=2021-05-21T19:59:43Z&se=2027-01-09T04:59:43Z&spr=https&sv=2020-02-10&sr=c&sig=Q%2B2o6yWWGhXh9ECRkzUhOjZdQnvoSw01FxBfmo17fsc%3D"
    },
    "resources": [
        {
            "apiVersion": "2017-05-10",
            "name": "linkedTemplate",
            "type": "Microsoft.Resources/deployments",
            "dependsOn": [],
            "properties": {
                "mode": "Incremental",
                "templateLink": {
                    "uri": "[variables('templatelink')]",
                    "contentVersion": "1.0.0.0"
                },
                "parameters": {
                    "vmList": {
                        "value": "[parameters('vmList')]"
                    },
                    "domainToJoin": {
                        "value": "[variables('domainToJoin')]"
                    },
                    "domainUsername": {
                        "value": "[variables('domainUsername')]"
                    },
                    "domainPassword": {
                        "reference": {
                            "keyVault": {
                                "id": "[variables('keyVaultRef')]"
                            },
                            "secretName": "[variables('domainpassword')]"
                        }
                    },
                    "ouPath": {
                        "value": "[variables('ouPath')]"
                    }
                }
            }
        }
    ]
}



DEPLOY

  # these key-value pairs are passed into the ARM Template's `parameters` block
  # replace the parameters below to fit your solution
  parameters= {
    vmList                           = var.server_name
    
  }

  deployment_mode = "Incremental"
  depends_on = [azurerm_virtual_machine_data_disk_attachment.azure_disk_attach]

}
*/