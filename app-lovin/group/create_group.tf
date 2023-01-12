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


resource "googleworkspace_group_members" "sales" {
  group_id = googleworkspace_group.sales.id

  members {
    email = "luis@luismendeze.com"
    role  = "MANAGER"
  }

  members {
    email = "test@luismendeze.com"
    role  = "MEMBER"
  }
}






