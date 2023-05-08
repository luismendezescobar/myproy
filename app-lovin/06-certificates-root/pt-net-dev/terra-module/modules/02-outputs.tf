output "dns_authorization" {
  value = google_certificate_manager_dns_authorization.default
}
output "dns_cname" {
  value = google_dns_record_set.cname
}
output "root_cert" {
  value = google_certificate_manager_certificate.root_cert
}
/*
output "certificate_map" {
    value = google_certificate_manager_certificate_map.certificate_map
  
}
*/
