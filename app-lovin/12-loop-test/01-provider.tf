/*we used this article

https://github.com/terraform-google-modules/terraform-google-project-factory/blob/master/modules/gsuite_enabled/README.md
*/
terraform {

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.53, < 5.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 3.53, < 5.0"
    }
  }
  required_version = ">= 0.13"
  
}
provider "google" {
  project = "prod-project-369617"
  region  = "us-central1"
}

provider "google-beta" {
  project = "prod-project-369617"
  region  = "us-central1"
}

