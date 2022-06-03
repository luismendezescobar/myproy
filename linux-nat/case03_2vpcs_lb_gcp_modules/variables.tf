
variable "project_id" {
  type=string
}

variable "vpc_info" {
  description = "information about the vpc"
  type = map(object({
    auto_create_subnetworks = bool
    subnetworks = list(object({
      subnet_name   = string
      ip_cidr_range = string
      region        = string
    }))
  }))
  default = {}
}

