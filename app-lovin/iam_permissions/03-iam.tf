locals {
    json_files = fileset("${path.module}/files","*.*")  
    json_data= { for file_name in local.json_files :
                file_name=>jsondecode(file("${path.module}/files/${file_name}"))} 

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

output "bindings" {
  value= {for key,value in local.json_data:key=>value} 
}