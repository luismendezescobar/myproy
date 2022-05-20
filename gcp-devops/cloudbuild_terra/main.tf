resource "google_container_registry" "registry" {
  project  = var.project_id
  location = "US"
}


resource "google_cloudbuild_trigger" "react-trigger" {
  //Source section
  github {
    owner = "luismendezescobar"
    name  = "myproy"
    //Events section  
    push {
       branch = "master"
       //or
       //tag    = "production"
      }
  }
  
//Configuration section
 // build config file
 filename = "gcp-devops/cloudbuild_terra/trigger-build.yaml"

ignored_files = [".gitignore"]
 // build config inline yaml
 #build {
 #    step {
 #    name       = "node" 
 #    entrypoint = "npm"
 #    args       = ["install"]
 #    }
 #    step{...}
 #    ...
 #  }
  //Advanced section

substitutions = {
    _FOO = "bar"
    _PROJECT_ID = var.project_id
}
options {
    machine_type = "N1_HIGHCPU_8"
    disk_size_gb = 100      
    log_streaming_option = "STREAM_OFF"
    worker_pool = "pool"
}

}