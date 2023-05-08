resource "google_compute_managed_ssl_certificate" "cert" {
  name        = var.name
  project     = var.project_id_certificate
  description = var.certificate_description
  managed {
    domains = var.certificate_domain_names
  }
}