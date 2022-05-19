resource "google_container_registry" "registry" {
  project  = var.project_id
  location = "EU"
}

resource "google_cloudbuild_trigger" "react-trigger" {
  github {
    owner = "rzeAkbari"
    name  = "gcp-cloud-build-run"
    push {
      branch = "master"
      //or
      //tag    = "production"
    }
  }

  substitutions = {
    _FOO = "bar"
    _BAZ = "qux"
  }

  filename      = "terraform/cloudbuild.yaml"
  ignored_files = [".gitignore", "terraform/*"]
  # build {
  #   step {
  #     name       = "node"
  #     entrypoint = "npm"
  #     args       = ["install"]
  #   }
  # }
}
