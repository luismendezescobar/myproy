terraform {
  required_providers {
    googleworkspace = {
      source = "hashicorp/googleworkspace"
      version = "0.7.0"
    }
  }
}

provider "googleworkspace" {
  # Configuration options
  customer_id = "C04hqny6x"
}
