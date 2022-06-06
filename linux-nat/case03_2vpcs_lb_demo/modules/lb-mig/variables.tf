
variable "project_id" {type=string}
variable "server_name" {type=string}
variable "zone" {type=string}
variable "instance_machine_type" {type=string}
variable "network_tags" {type=list}
variable "instance_description" {type=string}
variable "init_script" {type=string}
variable "auto_delete" {type=bool}
variable "disk_size_gb" {type=number}
variable "source_image" {type=string}
variable "boot_disk_type" {type=string}
variable "subnetwork_project" {type=string}
variable "subnetwork1" {type=string}
variable "subnetwork2" {type=string}
variable "external_ip" {type=list(string)}
variable "can_ip_forward" {type=bool}
#variable "service_account" {type=string}
variable "region" {type=string}
variable "health_check" {type = map }
variable "mig_info" {type = map }
variable "mig_zones" {type=list(string)}
variable "load_balancer_info01" {type = map }
variable "load_balancer_info02" {type = map }


