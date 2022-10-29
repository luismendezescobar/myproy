resource "google_service_account" "web" {
  account_id   = "cloud-sql-access"
  display_name = "Service account used to access cloud sql instance"
}

resource "google_project_iam_binding" "cloudsql_client" {
  role    = "roles/cloudsql.client"
  members = [
    "serviceAccount:cloud-sql-access@${data.google_project.project.project_id}.iam.gserviceaccount.com",
  ]
}

data "google_project" "project" {
}