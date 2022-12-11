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

locals {
 terraform_service_account = "luis@luismendeze.com"
}

provider "gsuite" {  
  alias ="impersonation"
  oauth_scopes = [
    "https://www.googleapis.com/auth/admin.directory.group",
    "https://www.googleapis.com/auth/apps.groups.settings",
    "https://www.googleapis.com/auth/admin.directory.user",
    "https://www.googleapis.com/auth/admin.directory.userschema",
  ]
}

data "google_service_account_access_token" "default" {
 provider                   = gsuite.impersonation
 target_service_account     = local.terraform_service_account
 scopes                     = ["userinfo-email", "cloud-platform"]
 lifetime                   = "1200s"
}


provider "gsuite" {
 project        = var.project_id
 access_token   = data.google_service_account_access_token.default.access_token
 request_timeout    = "60s"
}