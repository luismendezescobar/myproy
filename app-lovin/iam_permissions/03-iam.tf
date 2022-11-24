module "organization-iam-bindings" {
  source        = "terraform-google-modules/iam/google//modules/organizations_iam"
  organizations = ["my-project-91055-366623"]
  mode          = "additive"

  bindings = {
    "roles/analyticshub.viewer" = [
      "serviceAccount:sa-for-myproject@my-project-91055-366623.iam.gserviceaccount.com",
      "group:gcp-devops-group@luismendeze.com",
      "user:test@luismendeze.com",
    ]
    "roles/appengine.appViewer" = [
      "serviceAccount:my-service-account@prod-project-369617.iam.gserviceaccount.com",
      "group:gcp-devops-group@luismendeze.com",
      "user:devops-user01@luismendeze.com",
    ]
  }
}