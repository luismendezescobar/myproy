module "create_certificate" {
  source = "./modules"
  for_each = var.map_certificates

  dns_zone_name              = each.value.dns_zone_name
  domain                     = each.value.domain
  certificate_description    = each.value.certificate_description
  certificate_domain_names   = each.value.certificate_domain_names
  project_id_certificate_map = each.value.project_id_certificate_map
  
}

/*type of certificate id
projects/pt-net-dev-1j8y/locations/global/certificates/rootcert-7bd1
*/