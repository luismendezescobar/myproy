variable "project_id" {    
  type=string
  default = "qwiklabs-gcp-02-357dfee406f4"
}

variable "region" {
  type=string
  default = "us-uscentral1"
}

variable "map_armor" {
  type = map(object({
    name                          = string
    project_id                    = string
    layer_7_ddos_defense_config   = bool
    rule_visibility               = string
    rules       = list(object({
      action              = string
      priority            = number
      description         = optional(string,"")
      preview             = optional(bool,false)
      versioned_expr      = optional(string,"")
      src_ip_ranges       = optional(list(string),[])
      expression          = optional(string,"")      
      rate_limit          = optional(bool,false)
      ban_duration_sec    = optional(number,0)
      conform_action      = optional(string,"allow")
      exceed_action       = optional(string,"deny(502)")
      enforce_on_key_type = optional(string,"ALL")
      rate_limit_count    = optional(number,0)
      rate_interval_sec   = optional(number,0)

    }))
  }))
}