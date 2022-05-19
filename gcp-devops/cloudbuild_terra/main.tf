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
 filename = "trigger-build.yaml"

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
    _BAZ = "qux"
  }

}