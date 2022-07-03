/*

locals {
  
  #file_instances_to_build = { for server in var.fileservers : server.name => server }
  firewall_rules_map = { for item in var.firewall_rules : item. => server }
}

*/