variable "name" {
  type = string
}
variable "project_id" {
  type = string
}
variable "profile" {
  type = string
}
variable "min_tls_version" {
  type = string
}
variable "custom_features" {
  type = list(string)
  default = []
}


  