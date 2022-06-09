terraform {
  backend "gcs" {
    bucket  = "mybucket5-19-2022-03"
    prefix  = "nat-linux/state"
    impersonate_service_account = "tf-ta-cse-rd1@triggering-a-198-4bb0fe28.iam.gserviceaccount.com"
    #impersonate_service_account = var.tf_service_account
  }  
  
  required_version = "~> 1.1.0"  //terraform version required in the shell
  required_providers { 
    google = {
      source = "hashicorp/google"
      version = "~>4.23.0"       //this is the hashicorp modules version
    }
  }
}

