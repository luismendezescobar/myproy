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
      gae-service = {
        service_name            = "gae-service"
        service                 = "default"
        tag                     = ""
        version                 = "testflush4"
        type                    = "app_engine"
        region_endpoint         = "us-central1"
        iap                     = {}
        security_policy         = null          
      }        
      game-wordscapes-server	  = {
        service_name            = "game-wordscapes-server"
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
        default_service       = "gae-service"	            
        end_point_maps = {
          /*
          gae-announce = {
            service_name        = "gae-service"
            path                = ["/*"]
            path_prefix_rewrite = ""
            weight              = 0
          }*/
          run-v1 = {
            service_name        = "game-wordscapes-server"
            path                = ["/api/v1/*"]
            path_prefix_rewrite = ""
            weight              = 0
          }
          run-swagger = {
            service_name        = "game-wordscapes-server"
            path                = ["/swagger/*"]
            path_prefix_rewrite = ""
            weight              = 0
          }
          run-announce = {
            service_name        = "game-wordscapes-server"
            path                = ["/api/v1/announcement"]
            path_prefix_rewrite = ""
            weight              = 0
          }
        }
      }
      /*
      second = {
        path_matcher  = "second"
        domain        = "dev-dot-wordscapes-api.peoplefungames-qa.com"
        default_service       = "gae-service"	            
        end_point_maps = {
          gae-dot = {
            service_name        = "gae-service"
            path                = "/"
            path_prefix_rewrite = ""
            weight              = 0
          }
        }
      }*/
    }
  }
}
