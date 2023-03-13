output "cloud_run_ouputs" {
  value = {
	for k in module.cloud_run:k.service_name =>k
  }
}

