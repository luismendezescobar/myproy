/*based on this one
https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork_iam
*/
resource "google_compute_subnetwork_iam_binding" "binding" {
  project = google_compute_subnetwork.network-with-private-secondary-ip-ranges.project
  region = google_compute_subnetwork.network-with-private-secondary-ip-ranges.region
  subnetwork = google_compute_subnetwork.network-with-private-secondary-ip-ranges.name
  role = "roles/compute.networkUser"
  members = [
    "user:jane@example.com",
  ]
}