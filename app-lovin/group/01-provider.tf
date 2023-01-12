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

provider "googleworkspace" {  
  #credentials="service-account-file.json"
  customer_id = "C04hqny6x"
}
