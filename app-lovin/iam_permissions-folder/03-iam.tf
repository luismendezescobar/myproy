locals {
    json_files = fileset("${path.module}/files-iam-for-folder","*.*")  
    /*
    json_data= { for file_name in local.json_files :
                replace(file_name, ".json", "")=>jsondecode(file("${path.module}/files-iam-for-folder/${file_name}"))} 
    */
    json_data= { for file_name in local.json_files :
               split("-",file_name)[0]=>jsondecode(file("${path.module}/files-iam-for-folder/${file_name}"))} 
    
     
}

module "folder-iam" {
  source   = "terraform-google-modules/iam/google//modules/folders_iam"
  version = ">=7.4.1,<=8"  
  for_each = local.json_data

  folders = toset([each.key])         #convert the folder string to list, it's required that way for terraform.
  mode          = "additive" 
  bindings = each.value.folder_bindings
}


/*
GOOGLE_OAUTH_ACCESS_TOKEN="$(gcloud --impersonate-service-account=sa-pipeline-iam@devops-369900.iam.gserviceaccount.com auth print-access-token)" terraform apply
*/