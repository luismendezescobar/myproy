terraform {
  backend "gcs" {
    bucket  = "rd1-terraform-state"
    prefix  = "nat-linux"
    impersonate_service_account = "tf-ta-cse-rd1-dev-npe@ta-cse-rd1-dev-npe-d026.iam.gserviceaccount.com"
  }  
  required_version = "~> 1.1"  //terraform version required in the shell
  required_providers { 
    google = {
      source = "hashicorp/google"
      version = "~>4.23.0"       //this is the hashicorp modules version
    }
  }
}
