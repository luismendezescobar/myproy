variable "map_lb" {
  type = map(object({
    lb_name               = string    
    ipv4_name             = string
    end_points = list(object({
      service_name    = string
      service         = string
      tag             = string
      region_endpoint = string      
    }))
  }))