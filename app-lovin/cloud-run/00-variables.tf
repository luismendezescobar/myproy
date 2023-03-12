variable "project_id" {
  type = string
}
variable "region" {
  description = "Location for load balancer and Cloud Run resources"
  type = string
}
variable "cloud_run_map" {
  type = map(object({
    location   =string
    project_id =string
    image      =string
    service_account_email = string
    generate_revision_name = bool
    limits     = map(string)
    ports      = object({
                          name = string
                          port = number
                        })
    service_annotations = map(string)
    members    = list(string)  
    traffic_split = list(object({
                                  latest_revision = bool
                                  percent         = number
                                  revision_name   = string
                                  tag             = string
                                }))

  }))
  
}