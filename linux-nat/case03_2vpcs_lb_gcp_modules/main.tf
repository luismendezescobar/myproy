module "vpc_creation" {
  for_each = var.vpc_info
  source  = "terraform-google-modules/network/google//modules/vpc"
  version="~> 2.0.0"
  project_id    = var.project_id
  network_name  = each.key

}


module "firewall_rules" {
  for_each = var.firewall_rules
  
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  project_id   = var.project_id
  
  
  network_name = each.value.network_name
  rules        = each.value.rules
/*
  rules = [{
    name                    = "allow-ssh-ingress"
    description             = null
    direction               = "INGRESS"
    priority                = null
    ranges                  = ["0.0.0.0/0"]
    source_tags             = null
    source_service_accounts = null
    target_tags             = null
    target_service_accounts = null
    allow = [{
      protocol = "tcp"
      ports    = ["22"]
    }]
    deny = []
    log_config = {
      metadata = "INCLUDE_ALL_METADATA"
    }
  }]*/
}