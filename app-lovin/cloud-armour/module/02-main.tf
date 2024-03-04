# Cloud Armor configuration
resource "google_compute_security_policy" "policy" {
  name    = var.name
  project = var.project_id
  dynamic "adaptive_protection_config" {
    for_each = var.layer_7_ddos_defense_config == true ? [1] : []
    content {
      layer_7_ddos_defense_config {
        enable          = true
        rule_visibility = var.rule_visibility
      }
    }
  }
  dynamic "rule" {
    for_each = toset(var.rules)
    content {
      action      = rule.value.action
      priority    = rule.value.priority
      description = rule.value.description
      preview     = rule.value.preview != null ? rule.value.preview : false
      dynamic "match" {
        for_each = rule.value.versioned_expr != "" ? [1] : []
        content {
          versioned_expr = rule.value.versioned_expr
          config {
            src_ip_ranges = rule.value.src_ip_ranges
          }
        }
      }
      dynamic "match" {
        for_each = rule.value.expression != "" ? [1] : []
        content {
          expr {
            expression = rule.value.expression
          }
        }
      }
      dynamic "rate_limit_options" {
        for_each = rule.value.rate_limit == true ? [1] : []
        content {
          ban_duration_sec = rule.value.ban_duration_sec
          conform_action   = rule.value.conform_action
          exceed_action    = rule.value.exceed_action
          /*
          enforce_on_key_configs {
            enforce_on_key_type = rule.value.enforce_on_key_type
          }*/
          rate_limit_threshold {
            count        = rule.value.rate_limit_count
            interval_sec = rule.value.rate_interval_sec
          }                     
        }        
      }
    }
  }
}


