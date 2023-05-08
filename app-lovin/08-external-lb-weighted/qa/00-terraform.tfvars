project_id = "pt-services-dev-wepg"
region     = "us-central1"
domain     = "wordscapes-api.peoplefungames-qa.com"
map_services= [
  {
    "service_name"        = "default"
    "service"             = "pt-monitoring"
    "tag"                 = ""
    "type"                = "cloud_run"
    "path"                = "/*"
    "path_prefix_rewrite" = "/"    
  },
  {
    "service_name"        = "pt-identity"
    "service"             = "pt-identity"
    "tag"                 = ""
    "type"                = "cloud_run"
    "path"                = "/service2"
    "path_prefix_rewrite" = "/"
  }

]


map_services2 = {
  wordscapes_api_qa = {
    lb_name      = "dev-url-map"
    domain       = "wordscapes-api.peoplefungames-qa.com"
    prefix_match = "/weight"
    settings     = {
      default = {
        service_name          = "default"
        service             = "pt-monitoring"
        tag                 = ""
        type                = "cloud_run"
        path                = "/*"
        path_prefix_rewrite = "/"    
      }
      pt-identity = {
        service_name        = "pt-identity"
        service             = "pt-identity"
        tag                 = ""
        type                = "cloud_run"
        path                = "/service2"
        path_prefix_rewrite = "/"
      }
    }
  }


}