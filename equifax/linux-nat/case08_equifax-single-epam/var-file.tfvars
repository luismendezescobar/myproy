project_id         = "ta-cse-rd1-dev-npe-d026" #update the project here
tf_service_account = "tf-ta-cse-rd1-dev-npe@ta-cse-rd1-dev-npe-d026.iam.gserviceaccount.com"

server_nat_info = {
  "nat-server" = {
    #gce_image_family      = "efx-centos-7-s1"
    gce_image_family      = "efx-ubuntu-1804-s1"
    compute_image_project = "sec-eng-images-prd-5d4d"
    project_id            = "ta-cse-rd1-dev-npe-d026"
    machine_type          = "e2-highcpu-4"
    zone                  = "us-central1-b"
    labels = {
      project         = "nat_server_for_vertexia_workbench"
      owner           = "luis_mendez"
      cost_center     = "3429"
      division        = "0001"
      cmdb_bus_svc_id = "asve0048988"
      data_class      = "1"
    }
    auto_delete        = true
    kms_key_self_link  = "projects/sec-crypto-iam-npe-c8ed/locations/us-central1/keyRings/ta-cse-rd1-dev-npe-d026_bap0010739/cryptoKeys/gmwb-us-central1"
    disk_size          = 30
    disk_type          = "pd-standard"
    #subnetwork_project = "efx-gcp-ta-svpc-npe-6c9a"
    #subnetwork         = "projects/efx-gcp-ta-svpc-npe-6c9a/regions/us-central1/subnetworks/ta-cse-rd1-dev-npe-us-ta-npe-net-6-13"
    subnetwork         = "projects/ta-cse-rd1-dev-npe-d026/regions/us-central1/subnetworks/ta-cse-rd1-dev-npe-vm-us-14-isolated"
    subnetwork_project = "ta-cse-rd1-dev-npe-d026"
    external_ip        = ["false"]
    additional_networks = [{
      network            = "" //"ta-net-npe"  #network is not needed
      #subnetwork         = "projects/ta-cse-rd1-dev-npe-d026/regions/us-central1/subnetworks/ta-cse-rd1-dev-npe-vm-us-14-isolated"
      #subnetwork_project = "ta-cse-rd1-dev-npe-d026"
      subnetwork_project = "efx-gcp-ta-svpc-npe-6c9a"
      subnetwork         = "projects/efx-gcp-ta-svpc-npe-6c9a/regions/us-central1/subnetworks/ta-cse-rd1-dev-npe-us-ta-npe-net-6-13"    
      network_ip         = ""
      access_config      = []
    }]
    service_account = {
      email  = "tf-ta-cse-rd1-dev-npe@ta-cse-rd1-dev-npe-d026.iam.gserviceaccount.com"
      scopes = ["cloud-platform"]
    }
    //very important the tag otherwise it won't work
    tags = ["ta-cse-rd1-dev-npe-rd1-dev-vpc-1-useast1-isolated"]
    metadata = {
      ssh-keys = "lxm412:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC0esof5aGX6fplQar8TnlQDthPSQOfYP0GatUTgEvvhQYv+VKQww4kLqOb7nTff+vMATB8PZSVK1hQdW6jv7TOLteZuq66MsP81JnjefnRrTEND5r0/orzw6TH0kr66t+1Uj9HDAyEsC+nJBYvQ+z8rj0vVt1+QVAUXafP50CCUtbRIMmi64DzeofQUjvNO4F+CNvqRBK0T0XrXnFvJVLZUZ+89iZFj5TMmVo7OMRbBzufLBzgIV2tqN9m+/xlU8NKIs4X1ChTRrHOTYojGzSZizGA9m6Zmrza3zDQsqfqIKnb/QsDalbGkmkSUS/zp/oyxASLCbkRPGt3XiqYbFg9VPdLmIDK9jN1w0Ib9kQ9Z/dhsTg5CYwGF0o/yWK6XO8pwUxTX5x7iQKyVivdBRNTNBDhUmHE7k3rG6rpvgOceDPTQviKswqcx5QWLhE3XxUBnf653RgThSYmFfzXBvqtLXCpKVGeEu6m0OTi1EUM4wEpc6gRQPyPYYSwmg4d+9E= lxm412@USE-UUSDEV-005"
    }
    #startup_script            = "./modules/nat_init.sh"
    startup_script            = "./modules/nat_init_switch_ips_no_table.sh"
    description               = "NAT server for vertexIA workbench"
    can_ip_forward            = true
    allow_stopping_for_update = false
    additional_disks          = []
  },
}

server_vm_info = {
  "isolated-client01" = {
    disk_size             = 20
    compute_image_project = "sec-eng-images-prd-5d4d"
    gce_image_family      = "efx-centos-7-s1"
    labels = {
      project         = "server_in_isolated_network_for_vertexia_workbench"
      owner           = "luis_mendez"
      cost_center     = "3429"
      division        = "0001"
      cmdb_bus_svc_id = "asve0048988"
      data_class      = "1"
    }
    machine_type = "e2-micro"
    project      = "ta-cse-rd1-dev-npe-d026"
    service_account = {
      email  = "tf-ta-cse-rd1-dev-npe@ta-cse-rd1-dev-npe-d026.iam.gserviceaccount.com"
      scopes = ["cloud-platform"]
    }
    metadata = {
      ssh-keys = "lxm412:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC0esof5aGX6fplQar8TnlQDthPSQOfYP0GatUTgEvvhQYv+VKQww4kLqOb7nTff+vMATB8PZSVK1hQdW6jv7TOLteZuq66MsP81JnjefnRrTEND5r0/orzw6TH0kr66t+1Uj9HDAyEsC+nJBYvQ+z8rj0vVt1+QVAUXafP50CCUtbRIMmi64DzeofQUjvNO4F+CNvqRBK0T0XrXnFvJVLZUZ+89iZFj5TMmVo7OMRbBzufLBzgIV2tqN9m+/xlU8NKIs4X1ChTRrHOTYojGzSZizGA9m6Zmrza3zDQsqfqIKnb/QsDalbGkmkSUS/zp/oyxASLCbkRPGt3XiqYbFg9VPdLmIDK9jN1w0Ib9kQ9Z/dhsTg5CYwGF0o/yWK6XO8pwUxTX5x7iQKyVivdBRNTNBDhUmHE7k3rG6rpvgOceDPTQviKswqcx5QWLhE3XxUBnf653RgThSYmFfzXBvqtLXCpKVGeEu6m0OTi1EUM4wEpc6gRQPyPYYSwmg4d+9E= lxm412@USE-UUSDEV-005"
    }
    startup_script_file = "./modules/create-vm/init.sh"
    subnetwork          = "projects/ta-cse-rd1-dev-npe-d026/regions/us-central1/subnetworks/ta-cse-rd1-dev-npe-vm-us-14-isolated"
    zone                = "us-central1-b"
    tags                = ["ta-cse-rd1-dev-npe-rd1-dev-vpc-1-useast1-isolated"]
  },
  /*"shared-6-13-client01" = {
    disk_size             = 20
    compute_image_project = "sec-eng-images-prd-5d4d"
    gce_image_family      = "efx-centos-7-s1"
    labels = {
      project         = "server_in_shared_network_for_vertexia_workbench"
      owner           = "luis_mendez"
      cost_center     = "3429"
      division        = "0001"
      cmdb_bus_svc_id = "asve0048988"
      data_class      = "1"
    }
    machine_type = "e2-micro"
    project      = "ta-cse-rd1-dev-npe-d026"
    service_account = {
      email  = "tf-ta-cse-rd1-dev-npe@ta-cse-rd1-dev-npe-d026.iam.gserviceaccount.com"
      scopes = ["cloud-platform"]
    }
    metadata = {
      ssh-keys = "lxm412:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC0esof5aGX6fplQar8TnlQDthPSQOfYP0GatUTgEvvhQYv+VKQww4kLqOb7nTff+vMATB8PZSVK1hQdW6jv7TOLteZuq66MsP81JnjefnRrTEND5r0/orzw6TH0kr66t+1Uj9HDAyEsC+nJBYvQ+z8rj0vVt1+QVAUXafP50CCUtbRIMmi64DzeofQUjvNO4F+CNvqRBK0T0XrXnFvJVLZUZ+89iZFj5TMmVo7OMRbBzufLBzgIV2tqN9m+/xlU8NKIs4X1ChTRrHOTYojGzSZizGA9m6Zmrza3zDQsqfqIKnb/QsDalbGkmkSUS/zp/oyxASLCbkRPGt3XiqYbFg9VPdLmIDK9jN1w0Ib9kQ9Z/dhsTg5CYwGF0o/yWK6XO8pwUxTX5x7iQKyVivdBRNTNBDhUmHE7k3rG6rpvgOceDPTQviKswqcx5QWLhE3XxUBnf653RgThSYmFfzXBvqtLXCpKVGeEu6m0OTi1EUM4wEpc6gRQPyPYYSwmg4d+9E= lxm412@USE-UUSDEV-005"
    }
    startup_script_file = "./modules/create-vm/init.sh"
    subnetwork          = "projects/efx-gcp-ta-svpc-npe-6c9a/regions/us-central1/subnetworks/ta-cse-rd1-dev-npe-us-ta-npe-net-6-13"
    zone                = "us-central1-b"
    tags                = ["web"]
  },
  */
}

