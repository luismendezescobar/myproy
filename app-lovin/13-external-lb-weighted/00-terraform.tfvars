project_id = "pt-services-dev-wepg"


map_lb = {
  wordscapes-lb-qa = {
    lb_name               = "wordscapes-lb-qa"
    prefix_match          = "/"
    paths_class           = true
    weighted_class        = false
    ipv4_name             = "wordscapes-lb-ipv4-qa"
    ipv4_project          = "pf-wordscapes-qa-server"
    enable_ipv6           = true
    ipv6_name             = "wordscapes-lb-ipv6-qa"
    ipv6_project          = "pf-wordscapes-qa-server"
    https_redirect        = true
    enable_cdn            = false
    log_config_enable     = true
    default_service       = "gae-service"
    load_balancing_scheme = "EXTERNAL_MANAGED"
    end_points   = {
      hello1 = {
        service_name            = "hello1"
        service                 = "hello1"
        tag                     = ""
        version                 = "testflush4"
        type                    = "cloud_run"
        region_endpoint         = "us-central1"
        iap                     = {}
        security_policy         = null          
      }        
      hello2	  = {
        service_name            = "hello2"
        service                 = "game-wordscapes-server"
        tag                     = ""
        version                 = ""
        type                    = "cloud_run"
        region_endpoint         = "us-central1"
        iap                     = {}
        security_policy         = null
        custom_request_headers  = ["X-Client-Geo-Region: {client_region}", "X-Client-Geo-City: {client_city}", "X-Client-Geo-Subdivision: {client_region_subdivision}"]                  
      }       
    }
    url_map = {
      main = {
        path_matcher  = "main"
        domain        = "somedomain.com"
        default_service       = "hello1"	            
        end_point_maps = {
          run-v1 = {
            service_name        = "hello1"
            path                = ["/api/v1/*"]
            path_prefix_rewrite = ""
            weight              = 0
          }
          run-swagger = {
            service_name        = "hello1"
            path                = ["/swagger/*"]
            path_prefix_rewrite = ""
            weight              = 0
          }
          run-announce = {
            service_name        = "hello1"
            path                = ["/api/v1/announcement"]
            path_prefix_rewrite = ""
            weight              = 0
          }
        }
      }      
      second = {
        path_matcher  = "second"
        domain        = "some-other-domain.com"
        default_service       = "hello2"	            
        end_point_maps = {
          gae-dot = {
            service_name        = "hello2"
            path                = "/"
            path_prefix_rewrite = ""
            weight              = 0
          }
        }
      }
    }
  }
}
