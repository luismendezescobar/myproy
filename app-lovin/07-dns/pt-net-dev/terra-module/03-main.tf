module "create_certificate" {
  source = "./modules"
  for_each = var.map_certificates

  dns_zone_name              = each.value.dns_zone_name
  domain                     = each.value.domain
  certificate_description    = each.value.certificate_description
  certificate_domain_names   = each.value.certificate_domain_names
  project_id_certificate_map = each.value.project_id_certificate_map
  
}

module "dns-private-zone" {
  source  = "terraform-google-modules/cloud-dns/google"
  version = "4.0"
  project_id = "my-project"
  type       = "private"
  name       = "example-com"
  domain     = "example.com."


  recordsets = [
    {
      name    = ""
      type    = "NS"
      ttl     = 300
      records = [
        "127.0.0.1",
      ]
    },
    {
      name    = "localhost"
      type    = "A"
      ttl     = 300
      records = [
        "127.0.0.1",
      ]
    },
  ]
}