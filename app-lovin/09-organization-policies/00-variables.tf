variable "gcp_policies" {
  type = map(object({
    policy_for        = string
    project_id        = optional(string,null)
    
    organization_id   = optional(string,null)
    folder_id         = optional(string,null)
    
    constraint        = optional(string,null)
    policy_type       = optional(string,null)
    deny_list_length  = optional(string,null)
    deny              = optional(list(string),[])
    exclude_folders   = optional(list(string),[])
    exclude_projects  = optional(list(string),[])
    enforce           = optional(bool,null)
  }))
}