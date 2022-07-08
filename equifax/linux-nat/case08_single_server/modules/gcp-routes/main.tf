resource "google_compute_route" "from_local_to_github" {  
  name                  = "from-local-to-github"
  dest_range            = "140.82.112.0/20"
  network               = "network-eqfx-trdr"
  next_hop_instance     = "nat-server"
  next_hop_instance_zone="us-central1-b"
  priority              = 900
  tags = [ ]
}