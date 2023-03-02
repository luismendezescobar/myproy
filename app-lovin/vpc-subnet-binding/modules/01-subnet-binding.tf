/*based on this one
https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork_iam
*/
resource "google_compute_subnetwork_iam_binding" "binding" {
  project = var.project
  region = var.subnet_region
  subnetwork = var.subnet
  role = "roles/compute.networkUser"
  members = var.principal
}
