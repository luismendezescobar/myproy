resource "google_storage_bucket" "script-bucket" {
  name          = var.name
  location      = "US"
  project       = var.project_id
  force_destroy = true

}

//copy the scripts to the bucket
resource "google_storage_bucket_object" "dc01-script" {
  name   = "dc01.ps1"
  source = "./modules/create-dc/dc01.ps1" 
  bucket = var.name
  depends_on = [
    resource.google_storage_bucket.script-bucket
  ]
}

resource "google_storage_bucket_object" "specialize-node-script" {
  name   = "specialize-node.ps1"
  source = "./modules/create-vm-windows/specialize-node.ps1" 
  bucket = var.name
  depends_on = [
    resource.google_storage_bucket.script-bucket
  ]
}

resource "google_storage_bucket_object" "witness-node-script" {
  name   = "witness-node.ps1"
  source = "./modules/create-vm-windows/witness-node.ps1"
  bucket = var.name
  depends_on = [
    resource.google_storage_bucket.script-bucket
  ]
}