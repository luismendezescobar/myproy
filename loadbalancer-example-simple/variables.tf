
variable "project_id" {
  type=string
}
variable "vpc_name" {
  type=string
}
variable "region" {
  type=string
}
variable "subnet_name" {
  type=string
}
variable "ip_cidr_range" {
  type=string
}



variable "server_vm_info" {
  description = "the number of DB server instances"
  type = list(object({
    zone              = string
    name              = string
    network_ip        = string
    instance_type     = string
    source_image      = string
    boot_disk_size_gb = number    
    boot_disk_type    = string
    metadata          = map(string)
    instance_tags     = list(string)    
    description       = string
    init_script       = string
    loadbalancer      = string
    auto_delete       = bool
    additional_disks = list(object({
      name         = string
      disk_size_gb = number
      disk_type    = string
    }))
  }))
  default = []
}


variable "internal_ips" {
  type=map
}


variable "named_port" {
  description = "Only packets addressed to ports in the specified range will be forwarded to target. If empty, all packets will be forwarded."
  type = list(object({
    name = string
    port = string
  }))
  default = [ ]
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


