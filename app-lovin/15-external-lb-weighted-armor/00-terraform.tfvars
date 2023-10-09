project_id = "cloud-run-da-196-a1801216"


map_lb = {
  wordscapes-lb-qa = {
    lb_name               = "wordscapes-lb-qa"
    #prefix_match          = "/"
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
        security_policy         = "armor-policy"           
      }        
      hello2	  = {
        service_name            = "hello2"
        service                 = "game-wordscapes-server"
        tag                     = ""
        version                 = ""
        type                    = "cloud_run"
        region_endpoint         = "us-central1"
        iap                     = {}
        security_policy         = "armor-policy"         
      }       
    }
    url_map = {
      main = {
        path_matcher    = "main"
        domain          = "www.luismendeze.com"
        default_service = "hello1"	                    
        end_point_maps = {
          priority-1= {
            prefix_match          = "/api/v1/announcement"
            priority             = 1 
            weighted_be_services   = [
              {
                service_name  = "hello1"
                weight        = 100          
              },
	            {
                service_name  = "hello2"
                weight        = 0              
              }
            ]
          }
        }        
      }      
      second = {
        path_matcher     = "second"
        domain           = "luismendeze.com"
        default_service  = "hello2"
        prefix_match     = "/api/v1/announcement"	            
        end_point_maps = {
          priority-1= {
            prefix_match          = "/api/v1/announcement"
            priority             = 1 
            weighted_be_services   = [
              {
                service_name  = "hello1"
                weight        = 100          
              },
	            {
                service_name  = "hello2"
                weight        = 0              
              }
            ]
          }
        }
      }
    }
  }
}

map_armor = {
  first_policy ={
    name                          = "armor-policy"    
    layer_7_ddos_defense_config   = false
    rule_visibility               = "STANDARD"
    rules = [
      {
        action          ="deny(403)"
        priority        = "2147483647"
        description     = "default rule that blocks all"
        versioned_expr  = "SRC_IPS_V1"
        src_ip_ranges   = ["*"]
        expression      = ""
      },
      {
        action          ="deny(403)"
        priority        = "2147483646"
        description     = "default rule that blocks all"
        versioned_expr  = ""
        src_ip_ranges   = []
        expression      = "request.headers['host'].contains('luismendeze.com')" 
      },      {
        action          = "allow"         ##3. allow certain path
        priority        = "9900"              
        description     = "rule to allow access to /api/v1/announcement path"
        preview         = false
        versioned_expr  = ""
        src_ip_ranges   = []    
        expression      = "request.path.matches('/api/v1/announcement')" 
      },
    ]
  }
}