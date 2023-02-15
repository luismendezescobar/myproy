variable "name" {
  description = "The name for the project"
  type        = string
}
variable "project_id" {
  description = "The GCP project you want to enable APIs on"
  type        = string
}
variable "org_id" {
  description = "The organization ID."
  type        = string
}
variable "billing_account" {
  description = "The ID of the billing account to associate this project with"
  type        = string
}
variable "folder_id" {
  description = "The ID of a folder to host this project"
  type        = string
  default     = ""
}
variable "labels" {
  description = "Map of labels for project"
  type        = map(string)
  default     = {}
}
variable "auto_create_network" {
  description = "Create the default network"
  type        = bool
  default     = false
}
variable "activate_apis" {
  description = "The list of apis to activate within the project"
  type        = list(string)
  default     = []
}

variable "disable_services_on_destroy" {
  description = "Whether project services will be disabled when the resources are destroyed. https://www.terraform.io/docs/providers/google/r/google_project_service.html#disable_on_destroy"
  default     = true
  type        = bool
}
variable "disable_dependent_services" {
  description = "Whether services that are enabled and which depend on this service should also be disabled when this service is destroyed. https://www.terraform.io/docs/providers/google/r/google_project_service.html#disable_dependent_services"
  default     = true
  type        = bool
}
