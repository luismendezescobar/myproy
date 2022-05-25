
variable "project_id" {
  type=string
}
variable "vpc_name" {
  type=string
}

variable "subnetworks" {
  description = "List of maps of additional subnetworks"
  type = list(object({
    subnet_name   = string
    ip_cidr_range = number
    region        = string
  }))
  default = []
}

