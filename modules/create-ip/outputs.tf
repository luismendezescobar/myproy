
output "create-ip" {
  value       = google_compute_address.static_internal_address.address[*]
  
}


