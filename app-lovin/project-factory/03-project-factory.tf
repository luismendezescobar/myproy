locals {
    json_files = fileset("${path.module}/files-projects","*.json")  
    json_data= { for file_name in local.json_files :
                replace(file_name, ".json", "")=>jsondecode(file("${path.module}/files-iam/${file_name}"))} 
/*
    map_sa1={for key, value in local.json_data: key =>value.map_to_sa}
    map_sa2 = flatten([ for key, value in local.map_sa1:[
                            for item in value:{
                                project_id=key
                                members=item.members
                                role=item.role
                                sa=item.sa
                            }
                          ]
                      ])
    map_sa3 = {for x in local.map_sa2:join("-",[x.project_id,x.sa,x.role]) => x}
*/
}






/*
module "group" {
  source  = "terraform-google-modules/group/google"
  version = "~> 0.1"

  for_each = var.map_for_groups
  id           = "${each.key}@${each.value.domain}"
  display_name = each.key
  description  = each.value.description
  domain       = each.value.domain
  owners       = each.value.owners
  members      = each.value.members
}

output "group_output" {
  value = module.group
}


module "project-factory" {
  source = "terraform-google-modules/project-factory/google"
  version = "~> 14.1"
  for_each = var.map_for_project_factory

  name               = each.value.name
  random_project_id  = true
  random_project_id_length =4  
  org_id             = each.value.org_id
  billing_account    = each.value.billing_account
  auto_create_network = true
  activate_apis       = []

  svpc_host_project_id= each.value.svpc_host_project_id
  shared_vpc_subnets = each.value.shared_vpc_subnets
  group_name         = each.value.group_name
  group_role         = each.value.group_role
  folder_id          = each.value.folder_id 
  

}


data "google_organization" "org" {
  domain = "luismendeze.com"
}




output "output-value" {
  value = data.google_organization.org
}
*/

/*
GOOGLE_OAUTH_ACCESS_TOKEN="$(gcloud --impersonate-service-account=sa-project-factory@devops-369900.iam.gserviceaccount.com auth print-access-token)" terraform apply -var-file=02-terraform.tfvars
*/