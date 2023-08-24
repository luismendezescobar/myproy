map_lb = {
    pt-lb-dev = {
        lb_name               = "pt-lb-dev"            
        ipv4_name             = "pt-lb-ipv4-dev"
        end_points   = [
            {
            service_name            = "pt-backend-cr-identity-dev"
            service                 = "pt-identity"
            tag                     = "tag_01"
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