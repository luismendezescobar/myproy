/*
output "testout" {
 value=resource.azurerm_network_interface.nic
}
*/
output "Nic0" {  
  value = resource.azurerm_network_interface.nic.id
  
}
