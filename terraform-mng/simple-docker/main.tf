resource "docker_image" "my_nginx" {
    name        = "nginx:latest"
    keep_locally= false
}

resource "docker_container" "nginx" {
    image       = docker_image.my_nginx.latest
    name        = "tutorial"    
    ports {
        external=8000
        internal=80
    }
  
}