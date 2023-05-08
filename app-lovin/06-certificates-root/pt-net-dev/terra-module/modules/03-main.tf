resource "random_id" "tf_prefix" { 
  byte_length = 2
}
resource "google_certificate_manager_dns_authorization" "default" {
  name        = "dnsauth-${random_id.tf_prefix.hex}"
  description = "The default dns auth"
  domain      = var.domain
  labels = {
    "terraform" : true
  }
}
data "google_dns_managed_zone" "default" {
  name        = var.dns_zone_name
}
resource "google_dns_record_set" "cname" {
  name         = google_certificate_manager_dns_authorization.default.dns_resource_record[0].name
  managed_zone = data.google_dns_managed_zone.default.name
  type         = google_certificate_manager_dns_authorization.default.dns_resource_record[0].type
  ttl          = 300
  rrdatas      = [google_certificate_manager_dns_authorization.default.dns_resource_record[0].data]
}
resource "google_certificate_manager_certificate" "root_cert" {
  name        = "rootcert-${random_id.tf_prefix.hex}"
  description = var.certificate_description
  managed {
    domains = var.certificate_domain_names
    dns_authorizations = [
      google_certificate_manager_dns_authorization.default.id
    ]
  }
  labels = {
    "terraform" : true
  }
}

/*
resource "google_certificate_manager_certificate_map" "certificate_map" {
  name        = "certmap-${var.dns_zone_name}-${random_id.tf_prefix.hex}"
  project     =  var.project_id_certificate_map
  description = "${var.domain} certificate map"
  labels = {
    "terraform" : true
  }
}
resource "google_certificate_manager_certificate_map_entry" "first_entry" {
  name        = "map-entry-${var.dns_zone_name}-${random_id.tf_prefix.hex}"  
  description = "certificate map entry"
  map         = google_certificate_manager_certificate_map.certificate_map.name
  labels = {
    "terraform" : true
  }
  certificates = [google_certificate_manager_certificate.root_cert.id]
  hostname     = var.domain
}
*/

