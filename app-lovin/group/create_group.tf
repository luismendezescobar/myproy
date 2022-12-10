

# ------------------------------------------------
# Creating required usrs and groups inside G-Suite
#-------------------------------------------------



resource "gsuite_group" "skunkworks-team" {
  email       = "test-team@luismendeze.com"
  name        = "test-team@luismendeze.com"
  description = "luis team"
}
