terraform {
    required_version = "~>1.1.2"   # = equals,>=greater or equal, 
                                   # ~> approximately greater than , it must run a version 
                                   #that is equal to or greater than the last digit 
                                   #in this example it will run between 1.1.2 and 1.1.9
    backend "gcs" {
        bucket = "tf-state-storage"
        prefix = "terraform/config"      
    }
    required_providers {               #here goes the the project id
      google={                         #region, authentication 
          source = "hashicorp/google"  #when it runs in gcp shell
          version = ">=4.5.0"          #doesn't require provider block
      }
    }


}
/* BACKEND
all goes in the backend its save in the .tfstate file
example:
resource.computeengineinstance.webserver

*/