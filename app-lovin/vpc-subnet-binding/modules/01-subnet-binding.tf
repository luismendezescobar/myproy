/*based on this one
https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork_iam
*/

/*
resource "google_compute_subnetwork_iam_binding" "binding" {
  project = var.project
  region = var.subnet_region
  subnetwork = var.subnet
  role = "roles/compute.networkUser"
  members = var.principal
}
*/
/*
resource "google_compute_subnetwork_iam_member" "service_shared_vpc_subnet_users" {
  for_each = toset(var.principal)
  project = var.project
  region = var.subnet_region
  subnetwork = var.subnet
  role = "roles/compute.networkUser"
  member = each.value
}
*/
/*
resource "google_compute_subnetwork_iam_member" "service_shared_vpc_subnet_users" {  
  project = var.project
  region = var.subnet_region
  subnetwork = var.subnet
  role = "roles/compute.networkUser"
  member = "serviceAccount:sa-test@new-luis-id.iam.gserviceaccount.com"
}
*/

resource "google_compute_subnetwork_iam_binding" "binding" {  
  project = var.project
  region = var.subnet_region
  subnetwork = var.subnet
  role = "roles/compute.networkUser"
  members = ["serviceAccount:sa-test@new-luis-id.iam.gserviceaccount.com"]
}