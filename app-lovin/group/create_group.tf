

# ------------------------------------------------
# Creating required usrs and groups inside G-Suite
#-------------------------------------------------



resource "gsuite_group" "skunkworks-team" {
  email       = "test-team@luismendeze.com"
  name        = "test-team@luismendeze.com"
  description = "luis team"
}

resource "googleworkspace_group" "sales" {
  email       = "test-team@luismendeze.com"
  name        = "Sales"
  description = "Sales Group"

  aliases = ["paper-sales@example.com", "sales-dept@example.com"]

  timeouts {
    create = "1m"
    update = "1m"
  }
}