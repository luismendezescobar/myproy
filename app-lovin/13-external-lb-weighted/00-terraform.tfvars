project_id = "qwiklabs-gcp-00-7bb0877c9192"


map_lb = {
  wordscapes-lb-qa = {
    lb_name               = "wordscapes-lb-qa"
    prefix_match          = "/"
    paths_class           = false
    weighted_class        = true
    ipv4_name             = "wordscapes-lb-ipv4-qa"
    ipv4_project          = "pf-wordscapes-qa-server"
    enable_ipv6           = true
    ipv6_name             = "wordscapes-lb-ipv6-qa"
    ipv6_project          = "pf-wordscapes-qa-server"
    https_redirect        = true
    enable_cdn            = false
    log_config_enable     = true
    default_service       = "hello1"
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
        path_matcher    = "main"
        domain          = "somedomain.com"
        default_service = "hello1"	                    
        end_point_maps = {
          priority-1= {
            prefix_match          = "/api/v1/announcement"
            priority             = 1 
            weighted_be_services   = [
              {
                service_name  = "hello1"
                weight        = 10          
              },
	            {
                service_name  = "hello2"
                weight        = 90              
              }
            ]
          }
          priority-2= {
            prefix_match          = "/api/v1/announcement2"
            priority             = 2
            weighted_be_services   = [
              {
                service_name = "hello1"
                weight       = 90          
              },
	            {
                service_name = "hello2"
                weight       = 10              
              }
            ]
          }  
        }        
      }      
      second = {
        path_matcher     = "second"
        domain           = "some-other-domain.com"
        default_service  = "hello2"
        prefix_match     = "/api/v1/announcement"	            
        end_point_maps = {
          priority-1= {
            prefix_match          = "/api/v1/announcement"
            priority             = 1 
            weighted_be_services   = [
              {
                service_name  = "hello1"
                weight        = 10          
              },
	            {
                service_name  = "hello2"
                weight        = 90              
              }
            ]
          }
        }
      }
    }
  }
}
