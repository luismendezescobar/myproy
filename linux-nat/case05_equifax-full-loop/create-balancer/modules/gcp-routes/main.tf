
data "google_compute_forwarding_rule" "local" {
  name   ="forwarding-rule-local"  
  region = "us-central1"
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
/**************************************************************/

data "google_compute_forwarding_rule" "shared" {
  name   ="forwarding-rule-shared"  
  region = "us-central1"
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
