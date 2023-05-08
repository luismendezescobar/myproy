output "certificates_info" {
 value= {for key in module.create_certificate: key.cert.name=>key} 
}
