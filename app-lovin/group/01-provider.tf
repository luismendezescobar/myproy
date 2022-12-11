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
  project = var.project_id
  region  = var.region
}

provider "gsuite" {  
  impersonated_user_email = "luis@luismendeze.com"
  oauth_scopes = [
    "https://www.googleapis.com/auth/admin.directory.group",
    "https://www.googleapis.com/auth/apps.groups.settings",
    "https://www.googleapis.com/auth/admin.directory.user",
    "https://www.googleapis.com/auth/admin.directory.userschema",
  ]
}

