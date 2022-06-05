terraform {
/*  backend "gcs" {
    bucket  = "mybucket5-19-2022-02"
    prefix  = "state"
  }  
  */
  required_version = "~> 1.1.0"  
  required_providers { 
    google = {
      source = "hashicorp/google"
      version = "~>4.23.0"
    }
  }
}
provider "google" {
  project = "playground-s-11-dcbfd27e"
}