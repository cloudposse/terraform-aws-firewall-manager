module "shield_advanced_label" {
  for_each = local.shield_advanced_policies

  source  = "cloudposse/label/null"
  version = "0.25.0"

  attributes = [each.key]
  context    = module.this.context
}

resource "aws_fms_policy" "shield_advanced" {
  for_each = local.shield_advanced_policies

  name                               = module.shield_advanced_label[each.key].id
  delete_all_policy_resources        = lookup(each.value, "delete_all_policy_resources", true)
  delete_unused_fm_managed_resources = lookup(each.value, "delete_unused_fm_managed_resources", false)
  exclude_resource_tags              = lookup(each.value, "exclude_resource_tags", false)
  remediation_enabled                = lookup(each.value, "remediation_enabled", false)
  resource_type_list                 = lookup(each.value, "resource_type_list", null)
  resource_type                      = lookup(each.value, "resource_type", null)
  resource_tags                      = lookup(each.value, "resource_tags", null)

  dynamic "include_map" {
    for_each = lookup(each.value, "include_account_ids", [])

    content {
      account = include_map.value
    }
  }

  dynamic "exclude_map" {
    for_each = lookup(each.value, "exclude_account_ids", [])

    content {
      account = exclude_map.value
    }
  }

  security_service_policy_data {
    type = "SHIELD_ADVANCED"

    managed_service_data = lookup(each.value, "policy_data", null)!=null ? jsonencode({
      type = "SHIELD_ADVANCED"
      automaticResponseConfiguration = {
        automaticResponseStatus = lookup(each.value.policy_data, "automatic_response_status", "IGNORED")
        automaticResponseAction = (lookup(each.value.policy_data, "automatic_response_status", "IGNORED") == "ENABLED" &&
                                   lookup(each.value.policy_data, "automatic_response_action", "") == "BLOCK"
                                  ) ? "BLOCK" : null
      }
      overrideCustomerWebaclClassic = lookup(each.value.policy_data, "override_customer_webacl_classic", false)
    }):jsonencode({
        type = "SHIELD_ADVANCED"
    })
  }
}
