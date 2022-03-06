locals {
    rg = csvdecode(file("./resourcegroup.csv"))
}
/*
resource "local_file" "count_loop" {
    count = length(local.toppings)
    content     = "${local.toppings[count.index]}"
    filename = "${path.module}/${local.toppings[count.index]}.count"
}
*/
resource "local_file" "for_each_loop" {
    for_each = {for item in local.rg :item.rgname =>item}
    content     = "${each.value.rgname} and cost code is:${each.value.costcode}"
    filename = "${path.module}/${each.value.region}.txt"
}

output "name" {
  value={for item in local.rg :item.rgname =>item}
}

output "csv"{
    value=local.rg
}
