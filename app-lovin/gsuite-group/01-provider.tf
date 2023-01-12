/*we used this article

https://github.com/terraform-google-modules/terraform-google-project-factory/blob/master/modules/gsuite_enabled/README.md
*/
terraform {

  required_providers { 
    google = {
      source = "hashicorp/google"
      version = ">4.43, <=5"       //this is the hashicorp modules version
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
  user_project_override = true
  billing_project       = "devops-369900"
}


provider "googleworkspace" {
  # Configuration options
  #credentials="service-account-file.json"
  customer_id = "C04hqny6x"
  #impersonated_user_email = "luis@luismendeze.com"
  /*
  oauth_scopes = [
  "https://www.googleapis.com/auth/admin.directory.user",
  "https://www.googleapis.com/auth/admin.directory.userschema",  
  "https://www.googleapis.com/auth/admin.directory.group",
  "https://www.googleapis.com/auth/admin.directory.group.member",
  "https://www.googleapis.com/auth/apps.groups.settings"

  ]
  */
}
