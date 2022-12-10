

# ------------------------------------------------
# Creating required usrs and groups inside G-Suite
#-------------------------------------------------


provider "gsuite" {  
  impersonated_user_email = "luis@luismendeze.com"
  oauth_scopes = [
  "https://www.googleapis.com/auth/admin.directory.group",
  "https://www.googleapis.com/auth/admin.directory.user"
]
}

resource "gsuite_group" "skunkworks-team" {
  email       = "test-team@luismendeze.com"
  name        = "test-team@luismendeze.com"
  description = "luis team"
}
