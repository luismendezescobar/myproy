output "cloud_run_ouputs" {
  value = {
	for k in module.cloud_run:k.service_name =>k
  }
}

output "endpoint_groups_output" {
  value = {
    for k in resource.google_compute_region_network_endpoint_group.default: k.name =>k    
  }

}

