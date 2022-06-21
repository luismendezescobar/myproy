/*
data "google_compute_forwarding_rule" "local" {
  name   ="forwarding-rule-local"  
  region = "us-east1"
}

resource "google_compute_route" "from_local_to_shared" {  
  name          = "from-local-to-shared"
  dest_range    = "10.10.10.0/24"
  network       = "vpc-local"  
  next_hop_ilb  = data.google_compute_forwarding_rule.local.id
  priority              = 1000
  //tags                  = ["no-ip"]
  lifecycle {
    ignore_changes = [
      next_hop_ilb
    ]
  }

}
*/
/**************************************************************/

data "google_compute_forwarding_rule" "shared" {
  name   ="forwarding-rule-shared"  
  region = "us-east1"
}

resource "google_compute_route" "from_shared_to_local" {  
  name          = "from-shared-to-local"
  dest_range    = "10.10.11.0/24"
  network       = "vpc-shared"  
  next_hop_ilb  = data.google_compute_forwarding_rule.shared.id
  priority              = 1000
  //tags                  = ["no-ip"]
    lifecycle {
    ignore_changes = [
      next_hop_ilb
    ]
  }

}




























/*
resource "google_compute_route" "from_local_to_internet" {  
  name                  = "from-local-to-internet"
  dest_range            = "0.0.0.0/0"
  network               = "vpc-local"
  next_hop_instance     = "nat-server"
  next_hop_ilb          = google_compute_forwarding_rule.local.id
  priority              = 800
  tags                  = ["no-ip"]
}
*/


/*
resource "google_compute_route" "from_shared_to_internet" {  
  name                  = "from-shared-to-internet"
  dest_range            = "0.0.0.0/0"
  network               = "vpc-shared"
  next_hop_instance     = "nat-server"
  next_hop_instance_zone="us-east1-b"
  priority              = 800
  tags                  = ["no-ip"]
}

*/
/*
resource "google_compute_route" "from_shared_to_local" {  
  name                  = "from-shared-to-local"
  dest_range            = "10.10.11.0/24"
  network               = "vpc-shared"
  next_hop_instance     = "nat-server"
  next_hop_instance_zone="us-east1-b"
  priority              = 1000
  tags                  = ["no-ip"]
}
*/