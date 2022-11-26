locals {
    json_files = fileset("${path.module}/files-iam","*.*")  
    json_data= { for file_name in local.json_files :
                replace(file_name, ".json", "")=>jsondecode(file("${path.module}/files-iam/${file_name}"))} 
/*    
    maps= flatten([for value in local.json_data:value.map_to_sa] )         
    all_maps={
      for x in local.maps:join("-",[x.iam_project_id,x.sa,x.role]) => x
    }
*/
    map_sa1={for key, value in local.json_data: key =>value.map_to_sa}
    map_sa2 = flatten([ for key, value in local.map_sa1:[
                            for item in value:{
                                project_id=key
                                principal=item.principal
                                role=item.role
                                sa=item.sa
                            }
                          ]
                      ])
    map_sa3 = {for x in local.map_sa2:join("-",[x.project_id,x.sa,x.role]) => x}
}


module "project-iam-bindings" {
  source   = "terraform-google-modules/iam/google//modules/projects_iam"
  version = "7.4.1"
  for_each = local.json_data
  projects = toset([each.key])         #convert the project string to list, it's requred that way in the project.
  mode          = "additive"

  bindings = each.value.project_bindings
}


resource "google_service_account_iam_binding" "admin-account-iam" {
  for_each = local.map_sa3
  service_account_id = "projects/${each.key}/serviceAccounts/${each.value.sa}"
  role               = each.value.role

  members = each.value.principal
}

/*
output "bindings" {
  value= {for key,value in local.json_data:key=>value} 
}

output "map_output" {
  value= {for key,value in local.json_data:key=>value.map_to_sa} 
}

output "sa_map" {
  value=local.all_maps
}
*/
