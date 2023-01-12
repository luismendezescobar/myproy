# ------------------------------------------------
# Creating required usrs and groups inside G-Suite
#-------------------------------------------------
resource "googleworkspace_group" "sales" {
  email       = "sales-team@luismendeze.com"
  name        = "Sales"
  description = "Sales Group"
}


resource "googleworkspace_group_settings" "sales-settings" {
  #for_each = var.map_for_groups
  email = googleworkspace_group.sales.email

  allow_external_members = true

}






#GOOGLE_OAUTH_ACCESS_TOKEN="$(gcloud --impersonate-service-account=sa-project-factory@devops-369900.iam.gserviceaccount.com auth print-access-token)" terraform apply

