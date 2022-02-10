#az network vnet create --name myvpc --resource-group 1-c805ffc1-playground-sandbox --subnet-name default --location "West US"

terraform{
    backend "azurerm"{
        resource_group_name ="1-c805ffc1-playground-sandbox"     #variables can not be used, you have to put this manually here
        storage_account_name="mystorage292022"              #variables can not be used, you have to put this manually here
        container_name      ="statecontainer02"
        key                 ="terraform.tfstate"
    }
    required_providers {
      azurerm={
        source  = "hashicorp/azurerm"
        #version = "~>2.0"
      }
    }
}


# Configure the Azure provider
provider "azurerm" {    
	  subscription_id  = var.subguid
    #tenant_id       = "da67ef1b-ca59-4db2-9a8c-aa8d94617a16"      #manually here
    features {}
    skip_provider_registration = "true"
}

/*
resource "azurerm_lb" "lb" {
  name                = "lb-${lower(var.region)}-${lower(var.appabbrev)}-sql-${lower(terraform.workspace)}"
  location            = var.azure_location
  count               = var.node_count >= 2 ? 1 : 0
  resource_group_name = var.azure_resource_group_name
  sku                 = "Standard"
  tags                = var.resource_tags
  
  frontend_ip_configuration {
    name                          = "ClusterFrontEnd"
    subnet_id                     = var.azure_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
  
  frontend_ip_configuration {
    name                          = "SQLFrontEnd"
    subnet_id                     = var.azure_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_lb_backend_address_pool" "lbbap" {
  resource_group_name   = var.azure_resource_group_name
  loadbalancer_id       = azurerm_lb.lb[0].id
  name                  = "bep-${lower(var.appabbrev)}-sql-${lower(terraform.workspace)}"
  count                 = var.node_count >= 2 ? 1 : 0
}

resource "azurerm_lb_probe" "ntc-probe" {
  name                = "lbhp-${lower(var.appabbrev)}-ntc-${lower(terraform.workspace)}-tcp59998"
  resource_group_name = var.azure_resource_group_name
  loadbalancer_id     = azurerm_lb.lb[0].id
  port                = 59998
  interval_in_seconds = 5
  number_of_probes    = 2
  count               = var.node_count >= 2 ? 1 : 0
}

resource "azurerm_lb_probe" "sql-probe" {
  name                = "lbhp-${lower(var.appabbrev)}-ntc-${lower(terraform.workspace)}-tcp59999"
  resource_group_name = var.azure_resource_group_name
  loadbalancer_id     = azurerm_lb.lb[0].id
  port                = 59999
  interval_in_seconds = 5
  number_of_probes    = 2
  count               = var.node_count >= 2 ? 1 : 0
}

resource "azurerm_lb_rule" "ntc" {
  name                            = "lbr-${lower(var.appabbrev)}-ntc-${lower(terraform.workspace)}-all"
  resource_group_name             = var.azure_resource_group_name
  loadbalancer_id                 = azurerm_lb.lb[0].id
  enable_floating_ip              = true
  protocol                        = "All"
  frontend_port                   = "0"
  backend_port                    = "0"
  frontend_ip_configuration_name  = "ClusterFrontEnd"
  backend_address_pool_id         = azurerm_lb_backend_address_pool.lbbap[0].id
  probe_id                        = azurerm_lb_probe.ntc-probe[0].id
  #count                           = var.node_count >= 2 ? 1 : 0
}

resource "azurerm_lb_rule" "sql" {
  name                            = "lbr-${lower(var.appabbrev)}-sql-${lower(terraform.workspace)}-all"
  resource_group_name             = var.azure_resource_group_name
  loadbalancer_id                 = azurerm_lb.lb[0].id
  enable_floating_ip              = true
  protocol                        = "All"
  frontend_port                   = "0"
  backend_port                    = "0"
  frontend_ip_configuration_name  = "SQLFrontEnd"
  backend_address_pool_id         = azurerm_lb_backend_address_pool.lbbap[0].id
  probe_id                        = azurerm_lb_probe.sql-probe[0].id
  #count                           = var.node_count >= 2 ? 1 : 0
}

resource "azurerm_availability_set" "avset" {
  name                = "avset-${lower(var.region)}-${lower(var.appabbrev)}-sql-${lower(terraform.workspace)}"
  location            = var.azure_location
  resource_group_name = var.azure_resource_group_name
  managed             = true
  tags                = var.resource_tags
  count               = var.node_count >= 1 ? 1 : 0
}
*/
resource "azurerm_network_interface" "nic" {
  name                  = "nic-${lower(var.region)}-${lower(var.appabbrev)}-sql-${lower(terraform.workspace)}-${count.index}"
  location              = var.azure_location
  resource_group_name   = var.azure_resource_group_name
  tags                  = var.resource_tags
  count                 = var.node_count 

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.azure_subnet_id
    private_ip_address_allocation = "Dynamic"
    private_ip_address_version    = "IPv4"
    primary                       = true
  }
}
/*
resource "azurerm_network_interface_backend_address_pool_association" "nicbapassoc" {
  network_interface_id    = azurerm_network_interface.nic[count.index].id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lbbap[0].id
  count                   = var.node_count >= 1 ? var.node_count : 0
}
*/
resource "azurerm_virtual_machine" "vm" {
  name                              = "${lower(var.appabbrev)}sql${count.index}"
  availability_set_id               = azurerm_availability_set.avset[0].id
  location                          = var.azure_location
  resource_group_name               = var.azure_resource_group_name
  network_interface_ids             = [azurerm_network_interface.nic.*.id[count.index]]
  vm_size                           = var.node_size
  delete_os_disk_on_termination     = true
  delete_data_disks_on_termination  = true
  tags                              = var.resource_tags
  count                             = var.node_count

  storage_image_reference {
    #you can get it with this command az vm image list
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
/*this is not required for testing
  boot_diagnostics  {
    enabled   = false
    #storage_uri = var.bootdiags_primary_blob_endpoint
  }
*/


  storage_os_disk {
    name              = "${lower(var.appabbrev)}sql${count.index}-os"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
    os_type           = "Windows"
  }

  os_profile  {
    computer_name   = "${lower(var.appabbrev)}sql${count.index}"
    admin_username  = var.local_vm_adminusername
    admin_password  = var.local_vm_password
  }

  os_profile_windows_config {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
    timezone                  = var.vm_timezone
  }
}





/* this is not required for testing
resource "azurerm_managed_disk" "data" {
  name                  = "${lower(var.appabbrev)}-${lower(var.region)}-sql-${lower(terraform.workspace)}-data${count.index}"
  location              = var.azure_location
  resource_group_name   = var.azure_resource_group_name
  storage_account_type  = "Premium_LRS"
  create_option         = "Empty"
  disk_size_gb          = var.sql_data_disk_size_gb
  count                 = var.sql_data_disk_count > 0 ? var.sql_data_disk_count : 0 
  tags                  = var.resource_tags

  encryption_settings {
    enabled = true
  }
} 

resource "azurerm_managed_disk" "logs" {
  name                  = "${lower(var.appabbrev)}-${lower(var.region)}-sql-${lower(terraform.workspace)}-logs${count.index}"
  location              = var.azure_location
  resource_group_name   = var.azure_resource_group_name
  storage_account_type  = "Premium_LRS"
  create_option         = "Empty"
  disk_size_gb          = var.sql_logs_disk_size_gb
  count                 = var.sql_logs_disk_count > 0 ? var.sql_logs_disk_count : 0 
  tags                  = var.resource_tags

  encryption_settings {
    enabled = true
  }
}

resource "azurerm_managed_disk" "tempdb" {
  name                  = "${lower(var.appabbrev)}-${lower(var.region)}-sql-${lower(terraform.workspace)}-tempdb${count.index}"
  location              = var.azure_location
  resource_group_name   = var.azure_resource_group_name
  storage_account_type  = "Premium_LRS"
  create_option         = "Empty"
  disk_size_gb          = var.sql_tempdb_disk_size_gb
  count                 = var.sql_tempdb_disk_count > 0 ? var.sql_tempdb_disk_count : 0 
  tags                  = var.resource_tags

  encryption_settings {
    enabled = true
  }
}

resource "azurerm_virtual_machine_data_disk_attachment" "sqldata" {
  managed_disk_id     = azurerm_managed_disk.data[*].id
  virtual_machine_id  = azurerm_virtual_machine.vm[*].id
  lun                 = "${floor( (count.index + 1) / ceil( (count.index + 1) * 1.0 / var.sql_data_disk_count) )}" //count Index of 0 equates out to 1, OS disk is 0 
  count               = var.sql_data_disk_count > 0 ? var.sql_data_disk_count : 0 
  caching             = var.sql_data_disk_size_gb < 4095 ? "ReadOnly" : "None"
  create_option       = "Attach"
}

resource "azurerm_virtual_machine_data_disk_attachment" "sqllog" {
  managed_disk_id     = azurerm_managed_disk.logs[*].id
  virtual_machine_id  = azurerm_virtual_machine.vm[*].id
  lun                 = "${floor( (count.index + 1) / ceil( (count.index + 1) * 1.0 / var.sql_logs_disk_count) ) + var.sql_data_disk_count + 1 }" //count Index of 0 equates out to 1 + sql_data_disk_count, OS disk is 0 
  count               = var.sql_logs_disk_count > 0 ? var.sql_logs_disk_count : 0 
  caching             = "None"
  create_option       = "Attach"
}

resource "azurerm_virtual_machine_data_disk_attachment" "sqltempdb" {
  managed_disk_id     = azurerm_managed_disk.tempdb[*].id
  virtual_machine_id  = azurerm_virtual_machine.vm[*].id
  lun                 = "${floor( (count.index + 1) / ceil( (count.index + 1) * 1.0 / var.sql_tempdb_disk_count) ) + var.sql_logs_disk_count + var.sql_data_disk_count + 1 }" //count Index of 0 equates out to 1 + sql_data_disk_count + sql_logs_disk_count, OS disk is 0
  count               = var.sql_tempdb_disk_count > 0 ? var.sql_tempdb_disk_count : 0 
  caching             = var.sql_tempdb_disk_size_gb < 4095 ? "ReadOnly" : "None"
  create_option       = "Attach"
}
/*
resource "azurerm_recovery_services_protected_vm" "rspvm" {
  resource_group_name = var.shared_services_data.shared_services_rg_name
  recovery_vault_name = var.shared_services_data.recovery_services_vault_name
  source_vm_id        = azurerm_virtual_machine.vm[count.index].id
  backup_policy_id    = var.shared_services_data.backup_policy_id
  count               = var.node_count
  lifecycle {
    prevent_destroy = true
  }
}
*/
/*
resource "azurerm_virtual_machine_extension" "oms" {
  name                          = "MicrosoftMonitoringAgent"
  location                      = var.azure_location
  resource_group_name           = var.azure_resource_group_name
  virtual_machine_name          = azurerm_virtual_machine.sql[count.index].name
  publisher                     = "Microsoft.EnterpriseCloud.Monitoring"
  type                          = "MicrosoftMonitoringAgent"
  type_handler_version          = "1.0"
  auto_upgrade_minor_version    = true
  count                         = var.node_count

  settings = <<-BASE_SETTINGS
  {
    "workspaceId" : "${var.shared_services_data.oms_workspace_id}"
  }
  BASE_SETTINGS

  protected_settings = <<-PROTECTED_SETTINGS
  {
    "workspaceKey" : "${var.shared_services_data.oms_workspace_key}"
  }
  PROTECTED_SETTINGS
}
*/