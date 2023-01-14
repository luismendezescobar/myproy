
locals {
  map_owners={for x in var.owners:x=>"owners"}
  map_managers={for x in var.managers:x=>"managers"}
  map_members={for x in var.owners:x=>"members"}
  map_all=merge(map_owners,map_managers,map_members)

}