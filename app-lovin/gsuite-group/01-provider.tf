/*we used this article

https://github.com/terraform-google-modules/terraform-google-project-factory/blob/master/modules/gsuite_enabled/README.md
*/
terraform {

  required_providers { 
    google = {
      source = "hashicorp/google"
      version = "~>4.43"       //this is the hashicorp modules version
    }
    gsuite = {
      source = "DeviaVir/gsuite"
      version = "0.1.62"
    }
  }
}
provider "google" {
  project = var.project_id
  region  = var.region
}
provider "google-beta" {
  user_project_override = true
  billing_project       = "devops-369900"
}

