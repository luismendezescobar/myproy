project_id = "pt-net-dev-1j8y"
region     = "us-central1"

map_certificates = {  
  peoplefungames-dev-com = {
    dns_zone_name              = "peoplefungames-dev-com"
    domain                     = "peoplefungames-dev.com"
    certificate_description    = "root certificate for peoplefungames-dev-com"
    certificate_domain_names   = ["peoplefungames-dev.com", "*.peoplefungames-dev.com"]
    project_id_certificate_map =  "pt-services-dev-wepg"
  },

}

/*type of certificate id
projects/pt-net-dev-1j8y/locations/global/certificates/rootcert-7bd1
*/