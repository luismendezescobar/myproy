variable "gcp_policies" {
  type = map(object({
    policy_for        = string
    project_id        = optional(string,null)
    
    organization_id   = optional(string,null)
    folder_id         = optional(string,null)
    
    constraint        = optional(string,null)
    policy_type       = optional(string,null)
    deny_list_length  = optional(number,0)
    deny              = optional(list(string),[])
    allow_list_length = optional(number,0)
    allow             = optional(list(string),[])    
    exclude_folders   = optional(list(string),[])
    exclude_projects  = optional(list(string),[])
    enforce           = optional(bool,null)

  }))
}