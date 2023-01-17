map_for_groups = {
  gcp-new-luis = {
    owners       = ["luis@luismendeze.com"]
    members      = ["test@luismendeze.com",
                    "devops-user01@luismendeze.com",
                    "luismendezescobar@gmail.com"
                  ]
    allow_ext    = true
  },    
  
  gcp-service-project-luis = {
    owners       = ["luis@luismendeze.com"]
    members      = ["test@luismendeze.com","devops-user01@luismendeze.com"]
  },
  grp-gcp-prod-project-369617-developer = {
    members      = ["test01@luismendeze.com",
                    "test02@luismendeze.com",                    
                  ]
  },
  grp-gcp-prod-project-369617-data-engineer = {        
  },
  grp-gcp-prod-project-369617-read-only ={
    members      = ["test03@luismendeze.com",
                    "test02@luismendeze.com",                    
    ]
  },
  gcp-service-project-02 = { #<--------------------------next group name   
    members        = ["luis.mendez@peoplefun.com", #with external members
                      "luismendezescobar@gmail.com",
                      "luis@luismendeze.com",
                      "test01@luismendeze.com",
                      "test02@luismendeze.com",                   
                      ]  
    allow_ext      = true      #to enable external members
  },
  gcp-new-group-01 = {
    members      = ["test@luismendeze.com"]
  }

}

