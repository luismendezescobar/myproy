project_id = "pt-net-dev-1j8y"  #just for reference for the provider, the important is the one in the map below
region     = "us-central1"

map_certificates = {  
  wordscapes-cert-api-cdn-qa = {    
    certificate_description    = "certificate for peoplefungames-qa-com.com"
    certificate_domain_names   = ["wordscapes-api.peoplefungames-qa.com",
                                  #"wordscapes-cdn.peoplefungames-qa.com",
                                  ]
    project_id_certificate     =  "pt-services-dev-wepg"   #where is going to be created
  },

}

/*type of certificate id
projects/pt-services-dev-wepg/global/sslCertificates/wordscapes-cert-api-cdn-qa
*/