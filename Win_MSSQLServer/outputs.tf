output "nodes" {
  description = "Map output of the Node names and their IP addresses"
  value = zipmap(azurerm_virtual_machine.vm[*].name, azurerm_network_interface.nic[*].private_ip_address)
}

output "adminpassword" {
  description = "Admin login account password"
  value = var.local_vm_password
}