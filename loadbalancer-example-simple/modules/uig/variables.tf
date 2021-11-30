variable "name" {
  description = "Name of the Unmanaged Instance group"
  type        = string
}
variable "project_id" {
  description = "the project in which the resources are going to reside"
  type        = string
  default     = ""
}
variable "region" {
  description = " The name of the region where the resources are going to be deployed"
  type        = string
  default     = ""
}

variable "network" {
  type        = string
  description = "Name or self link network."
}

variable "subnetwork" {
  type        = string
  description = "Name or self link subnetwork."
}

variable "instances" {
  #type        = list(string) 
  description = "Instances to be put behind the unmanaged instance group"
}

variable "named_port" {
  description = "Only packets addressed to ports in the specified range will be forwarded to target. If empty, all packets will be forwarded."
  type = list(object({
    name = string
    port = string
  }))
  default = []
}

variable "health_check" {
  description = "type of health check to perform. eg. TCP or HTTP"
  type        = map
  default = {}
}
variable "frontend_ports" {
  description = "The Ports that the internal load balancer in front of the Managed Instance Group should listen for traffic on. If unused, will default to using the ports in named_ports."
  type        = list(number)
  default     = []
}

variable "frontend_name" {
  description = "The name of the forwarding rule, concatinated with the instance group name, so if ppgoa is sent, it will be ppgoal01-forwarding-rule"
  type        = string
  default     = ""
}