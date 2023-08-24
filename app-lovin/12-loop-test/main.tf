locals {
  endpoints=var.map_lb["pt-lb-dev"].end_points
}


output "some_endpoints" {
  value={
    for serviceObj in local.endpoints:
      serviceObj.service_name => {
        description = "${serviceObj.service_name}${serviceObj.tag}"
      }
  }
}




/*
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
*/


/*
map_lb = {
    pt-lb-dev = {
        lb_name               = "pt-lb-dev"            
        ipv4_name             = "pt-lb-ipv4-dev"
        end_points   = [
            {
            service_name            = "pt-backend-cr-identity-dev"
            service                 = "pt-identity"
            tag                     = "tag01"
            region_endpoint         = "us-central1"
            },
            {
                service_name        = "pt-backend-cr-analytics-dev"
                service             = "pt-analytics"
                tag                 = "tag_02"
                region_endpoint     = "us-central1"
            }
        ]
    }
}
*/