
locals {
  map_owners={for x in var.owners:x=>"owners"}
}