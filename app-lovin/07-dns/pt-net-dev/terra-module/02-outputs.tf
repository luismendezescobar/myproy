output "certificates_info" {
 value= {for key in module.create_certificate: key.root_cert.name=>key} 
}
/*
output "certificate_map" {
  value= {for key in module.create_certificate: key.certificate_map.name=>key} 
}
*/