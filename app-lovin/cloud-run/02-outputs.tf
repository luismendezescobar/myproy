output "cloud_run_ouputs" {
  value = {
	for k in module.cloud_run:k.service_name =>k
  }
}

output "external_ip_output" {
  value = resource.google_compute_global_address.external_ip
}
