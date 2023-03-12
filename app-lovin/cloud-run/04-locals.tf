locals {
  cloud_run_services= {for k in module.cloud_run:k.service_name =>k}
}