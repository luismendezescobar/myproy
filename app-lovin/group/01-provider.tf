/*we used this article

https://github.com/terraform-google-modules/terraform-google-project-factory/blob/master/modules/gsuite_enabled/README.md
*/
terraform {

  required_providers { 
    google = {
      source = "hashicorp/google"
      version = "~>4.43"       //this is the hashicorp modules version
    }
    googleworkspace = {
      source = "hashicorp/googleworkspace"
      version = "0.7.0"
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
/*
provider "googleworkspace" {  
  credentials="service-account-file.json"
  customer_id = "C04hqny6x"
}
*/

provider "google" {
  alias = "impersonate"

  scopes = [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/userinfo.email",
  ]
}

data "google_service_account_access_token" "default" {
  provider               = google.impersonate
  target_service_account = "sa-project-factory@devops-369900.iam.gserviceaccount.com"
  scopes                 = ["userinfo-email", "cloud-platform", 
                            "https://www.googleapis.com/auth/admin.directory.group",
                            "https://www.googleapis.com/auth/apps.groups.settings"]
  lifetime               = "1200s"
}



provider "googleworkspace" {
  customer_id   = "C04hqny6x"
  access_token  = data.google_service_account_access_token.default.access_token
}