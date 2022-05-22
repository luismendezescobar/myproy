provider "google" {
  #version = "~> 2.0, >= 2.5.1"
  alias   = "tokengen"
}
data "google_client_config" "default" {
  provider = google.tokengen
}
data "google_service_account_access_token" "sa" {
  provider               = google.tokengen
  target_service_account = "terraform@triggering-a-198-f7b37e90.iam.gserviceaccount.com"
  lifetime               = "600s"
scopes = [
    "https://www.googleapis.com/auth/cloud-platform",
  ]
}

/******************************************
  GA Provider configuration
 *****************************************/

provider "google" {
  #version      = "~> 2.0, >= 2.5.1"
  access_token = data.google_service_account_access_token.sa.access_token
  project      = "triggering-a-198-f7b37e90"
}

