
locals {
  map_owners={for x in var.owners:x=>"owners"}
  map_managers={for x in var.managers:x=>"managers"}
  map_members={for x in var.members:x=>"members"}
  map_all=merge(local.map_owners,local.map_managers,local.map_members)
  final_map={"mymap" => local.map_all}

}