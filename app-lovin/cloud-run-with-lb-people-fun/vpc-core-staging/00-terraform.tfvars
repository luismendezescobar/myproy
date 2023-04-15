project_id = "pt-services-dev-wepg"
region     = "us-central1"
domain     = "luismendeze.com"
map_services= [
  {
    "service_name"        = "default"
    "service"             = "pt-identity"
    "tag"                 = ""
    "type"                = "cloud_run"
    "path"                = "/*"
    "path_prefix_rewrite" = "/"    
  },
  {
    #"service_name"        = "pt-analytics"
    #"service"             = "pt-analytics"
    "service_name"        = "cloud-run-test-luis"
    "service"             = "hello"
    "tag"                 = ""
    "type"                = "cloud_run"
    "path"                = "/service2"
    "path_prefix_rewrite" = "/"
  },  
  /*
  {
    "service_name"        = "cloud-run-test-luis"
    "service"             = "hello"
    "tag"                 = ""
    "type"                = "cloud_run"
    "path"                = "/service3"
    "path_prefix_rewrite" = "/"
  }
*/
]