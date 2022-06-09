terraform {
/*  backend "gcs" {
    bucket  = "mybucket5-19-2022-02"
    prefix  = "state"
  }  
  */
  required_version = "~> 1.1.0"  //terraform version required in the shell
  required_providers { 
    google = {
      source = "hashicorp/google"
      version = "~>4.23.0"       //this is the hashicorp modules version
    }
  }
}
provider "google" {
  #project = "playground-s-11-74401450"
  project = var.project_id
}