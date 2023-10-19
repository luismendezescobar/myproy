project_id = "qwiklabs-gcp-01-69c7cad7dbe7"


map_lb = {
  wordscapes-lb-qa = {
    lb_name               = "test-lb"
    #prefix_match          = "/"
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
    default_service       = "default-backend"
    load_balancing_scheme = "EXTERNAL_MANAGED"
    create_storage        = true
    storage   = {
      default-backend = {          
        backend_name                = "default-backend"
        bucket_name                 = "default-backend-10-18-2023-01"
        enable_cdn                  = true
        bucket_location             = "us-central1"
        uniform_bucket_level_access = true
        storage_class               = "STANDARD"
        force_destroy               = true
        description                 = "storage for space breaker dev"     
        member                      = "allUsers"
      }
    }
    cdn_policy = {
      cache_mode                   = "CACHE_ALL_STATIC"
      client_ttl                   = 3600
      default_ttl                  = 3600
      max_ttl                      = 86400
      negative_caching             = false
      serve_while_stale            = 0
    }    
    end_points   = {
      hello1 = {
        service_name            = "hello1"
        service                 = "hello1"
        tag                     = ""
        version                 = ""
        type                    = "cloud_run"
        region_endpoint         = "us-central1"
        iap                     = {}
        security_policy         = null          
      }        
      hello2	  = {
        service_name            = "hello2"
        service                 = "hello2"
        tag                     = ""
        version                 = ""
        type                    = "cloud_run"
        region_endpoint         = "us-central1"
        iap                     = {}
        security_policy         = null
      }       
    }
    url_map = {
      main = {
        path_matcher    = "main"
        domain          = "www.luismendeze.com"
        default_service = "hello1"	                    
        end_point_maps = {
          cloud-run= {
            service_name        = "hello1"
            path                = ["/run"]
            path_prefix_rewrite = ""
          }
        }
      }
      second = {
        path_matcher     = "second"
        domain           = "luismendeze.com"
        default_service  = "hello2"    
        end_point_maps = {
          cdn= {
            service_name         = "default-backend"
            path                 = ["cdn"]
            path_prefix_rewrite  = ""
            bucket_backend       = true         
          }
        }
      }
    }
  }
}
