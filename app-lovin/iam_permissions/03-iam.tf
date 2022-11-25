locals {
    json_files = fileset("${path.module}/files-iam","*.*")  
    json_data= { for file_name in local.json_files :
                replace(file_name, ".json", "")=>jsondecode(file("${path.module}/files-iam/${file_name}"))} 
}


/*
module "organization-iam-bindings" {
  source   = "terraform-google-modules/iam/google//modules/projects_iam"
  version = "7.4.1"
  for_each = local.json_data
  projects = ["my-project-91055-366623"]
  mode          = "additive"

  bindings = {
    "roles/analyticshub.viewer" = [
      "serviceAccount:sa-for-myproject@my-project-91055-366623.iam.gserviceaccount.com",
      #"group:gcp-devops-group@luismendeze.com",
      "user:test@luismendeze.com",
    ]
    "roles/appengine.appViewer" = [
      "serviceAccount:my-service-account@prod-project-369617.iam.gserviceaccount.com",
      #"group:gcp-devops-group@luismendeze.com",
      "user:devops-user01@luismendeze.com",
    ]
  }
}
*/

module "project-iam-bindings" {
  source   = "terraform-google-modules/iam/google//modules/projects_iam"
  version = "7.4.1"
  for_each = local.json_data
  projects = toset([each.key])         #convert the project string to list, it's requred that way in the project.
  mode          = "additive"

  bindings = each.value.project_bindings
}

/*
resource "google_service_account_iam_binding" "admin-account-iam" {
  service_account_id = google_service_account.sa.name
  role               = "roles/iam.serviceAccountUser"

  members = [
    "user:jane@example.com",
  ]
}
*/

output "bindings" {
  value= {for key,value in local.json_data:key=>value} 
}

output "map_output" {
  value= {for key,value in local.json_data:key=>value.map_to_sa} 
}
