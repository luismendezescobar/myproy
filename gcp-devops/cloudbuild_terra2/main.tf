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
       //tag    = "production"      ###is it possible to use regex??
      }
  }
  //Configuration section
  // build config file
  #filename = "gcp-devops/cloudbuild_terra/trigger-build.yaml"

  ignored_files = [".gitignore"]
  // build config inline yaml
  build {
      # Build the container image
    step{
        name       = "gcr.io/cloud-builders/docker"
        #entrypoint = "npm"
        args       = ["build", "-t", "gcr.io/$_PROJECT_ID/build-run-image", "gcp-devops/cloudbuild_terra2/cloud_build/build-run/."]
    }
      # Push the container image to Container Registry
    step{
      name       = "gcr.io/cloud-builders/docker" 
      args       = ["push", "gcr.io/$_PROJECT_ID/build-run-image"]
    }
    # Deploy container image to Cloud Run
    step{
      name       = "gcr.io/cloud-builders/gcloud" 
      args       = ["run", "deploy", "cloud-run-deploy", "--image", "gcr.io/$_PROJECT_ID/build-run-image", "--region", "us-central1", "--platform", "managed", "--allow-unauthenticated"]
    } 
    artifacts {
      images = ["gcr.io/$_PROJECT_ID/build-run-image"]
    }
    //Advanced section
   
    options {
      machine_type = "UNSPECIFIED"
      disk_size_gb = 100      
      log_streaming_option = "STREAM_ON"
     
    }
    
  }  
  substitutions = {
      _FOO = "bar"
      _PROJECT_ID = var.project_id
  }
}