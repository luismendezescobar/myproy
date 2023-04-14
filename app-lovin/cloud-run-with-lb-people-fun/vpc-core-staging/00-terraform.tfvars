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
    "service_name"        = "cloud-run-test"
    "service"             = "test-luis"
    "tag"                 = ""
    "type"                = "cloud_run"
    "path"                = "/service2"
    "path_prefix_rewrite" = "/"
  }

]