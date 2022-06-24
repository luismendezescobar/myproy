
resource "google_compute_route" "from_local_to_outside" {  
  name                  = "from-local-to-outside"
  dest_range            = "0.0.0.0/24"
  network               = "vpc-local"
  next_hop_instance     = "nat-server"
  next_hop_instance_zone="us-central1-b"
  priority              = 900
  tags                  = ["no-ip"]
}