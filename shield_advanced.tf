module "shield_advanced_label" {
  for_each = local.shield_advanced_policies

  source  = "cloudposse/label/null"
  version = "0.25.0"

  attributes = [each.key]
  context    = module.this.context
}

resource "aws_fms_policy" "shield_advanced" {
  for_each = local.shield_advanced_policies

  name                        = module.shield_advanced_label[each.key].id
  delete_all_policy_resources = lookup(each.value, "delete_all_policy_resources", true)
  exclude_resource_tags       = lookup(each.value, "exclude_resource_tags", false)
  remediation_enabled         = lookup(each.value, "remediation_enabled", false)
  resource_type_list          = lookup(each.value, "resource_type_list", null)
  resource_type               = lookup(each.value, "resource_type", null)
  resource_tags               = lookup(each.value, "resource_tags", null)

  include_map {
    account = lookup(each.value, "include_account_ids", [])
  }

  exclude_map {
    account = lookup(each.value, "exclude_account_ids", [])
  }

  # Non-CloudFront resources
  dynamic "security_service_policy_data" {
    for_each = lookup(each.value, "policy_data", null) == null ? [0] : []
    content {
      type = "SHIELD_ADVANCED"
      managed_service_data = jsonencode({
        type = "SHIELD_ADVANCED"
      })
    }
  }

  # Used only for CloudFront
  dynamic "security_service_policy_data" {
    for_each = lookup(each.value, "policy_data", null) == null ? [] : [each.value]
    content {
      type = "SHIELD_ADVANCED"

      managed_service_data = jsonencode({
        type = "SHIELD_ADVANCED"

        automaticResponseConfiguration = {
          # "ENABLED|IGNORED|DISABLED"
          automaticResponseStatus = lookup(each.value.policy_data, "automaticResponseStatus", null)
          # "BLOCK|COUNT"
          automaticResponseAction = lookup(each.value.policy_data, "automaticResponseAction", null)
          # true|false
          overrideCustomerWebaclClassic = lookup(each.value.policy_data, "overrideCustomerWebaclClassic", false)
        }

      })
    }
  }

}
