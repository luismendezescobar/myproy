resource "azurerm_lb" "lb" {
  name                = var.lb_name
  location            = var.lb_location
  #location            = "Central US"
  resource_group_name = var.azure_resource_group_name
  sku                 = "Standard"
  tags                = var.resource_tags
  
  frontend_ip_configuration {
    name                          = "ClusterFrontEnd"
    subnet_id                     = var.lb_azure_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
  
  frontend_ip_configuration {
    name                          = "SQLFrontEnd"
    subnet_id                     = var.lb_azure_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_lb_backend_address_pool" "lbbap" {
  #resource_group_name   = var.azure_resource_group_name
  loadbalancer_id       = azurerm_lb.lb.id
  name                  = var.lb-backendpool-name
}

resource "azurerm_lb_probe" "ntc-probe" {
  name                = var.lb_probe_ntc
  resource_group_name = var.azure_resource_group_name
  loadbalancer_id     = azurerm_lb.lb.id
  port                = 59998
  interval_in_seconds = 5
  number_of_probes    = 2 
}

resource "azurerm_lb_probe" "sql-probe" {
  name                = var.lb_probe_sql
  resource_group_name = var.azure_resource_group_name
  loadbalancer_id     = azurerm_lb.lb.id
  port                = 59999
  interval_in_seconds = 5
  number_of_probes    = 2  
}

resource "azurerm_lb_rule" "ntc" {
  name                            = var.lb_rule_ntc
  resource_group_name             = var.azure_resource_group_name
  loadbalancer_id                 = azurerm_lb.lb.id
  enable_floating_ip              = true
  protocol                        = "All"
  frontend_port                   = "0"
  backend_port                    = "0"
  frontend_ip_configuration_name  = "ClusterFrontEnd"
  #backend_address_pool_id         = azurerm_lb_backend_address_pool.lbbap.id
  probe_id                        = azurerm_lb_probe.ntc-probe.id  
}

resource "azurerm_lb_rule" "sql" {
  name                            = var.lb_rule_sql
  resource_group_name             = var.azure_resource_group_name
  loadbalancer_id                 = azurerm_lb.lb.id
  enable_floating_ip              = true
  protocol                        = "TCP"
  frontend_port                   = "1433"
  backend_port                    = "1433"
  frontend_ip_configuration_name  = "SQLFrontEnd"
  #backend_address_pool_id         = azurerm_lb_backend_address_pool.lbbap.id
  probe_id                        = azurerm_lb_probe.sql-probe.id  
}

resource "azurerm_availability_set" "avset" {
  name                = var.avset_name
  location            = var.lb_location
  resource_group_name = var.azure_resource_group_name
  managed             = true
  tags                = var.resource_tags  
}

##############Here comes the tricky part####################################################

resource "azurerm_network_interface_backend_address_pool_association" "nicbapassoc" {
  
  for_each                = var.instances
 
  network_interface_id    = each.value
  ip_configuration_name   = each.key
  backend_address_pool_id = azurerm_lb_backend_address_pool.lbbap.id
  
}

