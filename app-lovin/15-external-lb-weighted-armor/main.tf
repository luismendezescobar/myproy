############ call to create a cloud armor policy  ########

module "create_cloud_armor_policy" {
  source                      = "./cloud-armor"
  for_each                    = var.map_armor
  name                        = each.value.name
  project_id                  = var.project_id
  layer_7_ddos_defense_config = each.value.layer_7_ddos_defense_config  
  rule_visibility             = each.value.rule_visibility
  rules                       = each.value.rules  
}



module "create_lb_wordscapes_qa" {
  source                = "./lb-https-global"
  for_each              = var.map_lb
  project_id            = var.project_id
  lb_name               = each.value.lb_name  
  //prefix_match          = each.value.prefix_match
  paths_class           = each.value.paths_class
  weighted_class        = each.value.weighted_class
  ipv4_name             = each.value.ipv4_name
  ipv4_project          = each.value.ipv4_project
  enable_ipv6           = each.value.enable_ipv6
  ipv6_name             = each.value.ipv6_name
  ipv6_project          = each.value.ipv6_project
  #certificates          = [for key in module.create_certificate : key.cert.id]
  https_redirect        = each.value.https_redirect
  enable_cdn            = each.value.enable_cdn
  log_config_enable     = each.value.log_config_enable
  default_service       = each.value.default_service
  load_balancing_scheme = each.value.load_balancing_scheme
  end_points            = each.value.end_points
  url_map               = each.value.url_map
  #ssl_policy            = module.create_ssl_policy.ssl_policy.self_link
  depends_on = [ module.create_cloud_armor_policy ]
}
