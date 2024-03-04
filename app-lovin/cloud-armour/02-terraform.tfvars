  map_armor = {
    first_policy ={
      name                          = "armor-dev-policy"
      project_id                    = ""
      layer_7_ddos_defense_config   = false
      rule_visibility               = "STANDARD"
      rules = [
        {
          action          = "allow"
          priority        = "2147483647"
          description     = "default rule that allows all"
          versioned_expr  = "SRC_IPS_V1"
          src_ip_ranges   = ["*"]          
        },
        {
          action              = "allow"
          priority            = "9990"
          description         = "rule to allow access to path"                    
          expression          = "request.path.matches('/*')" 
          rate_limit          = true
          conform_action      = "allow"
          exceed_action       = "deny(502)"
          enforce_on_key_type = "ALL"
          rate_limit_count    = 15
          rate_interval_sec   = 30

        },
      ]
    }
  }