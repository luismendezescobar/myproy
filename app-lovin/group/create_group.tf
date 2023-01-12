

# ------------------------------------------------
# Creating required usrs and groups inside G-Suite
#-------------------------------------------------


resource "googleworkspace_group" "sales" {
  email       = "sales-team@luismendeze.com"
  name        = "Sales"
  description = "Sales Group"

}