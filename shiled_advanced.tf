module "shiled_advanced_label" {
  for_each = local.shiled_advanced_policies

  source  = "cloudposse/label/null"
  version = "0.24.1"

  attributes = [each.key]
  context    = module.this.context
}

resource "aws_fms_policy" "shiled_advanced" {
  for_each = local.shiled_advanced_policies

  name                        = module.shiled_advanced_label[each.key].id
  delete_all_policy_resources = lookup(each.value, "delete_all_policy_resources", true)
  exclude_resource_tags       = lookup(each.value, "exclude_resource_tags", false)
  remediation_enabled         = lookup(each.value, "remediation_enabled", false)
  resource_type_list          = lookup(each.value, "resource_type_list", null)
  resource_type               = lookup(each.value, "resource_type", null)
  resource_tags               = lookup(each.value, "resource_tags", null)

  dynamic "include_map" {
    for_each = lookup(each.value, "include_account_ids", null) != null ? [1] : []

    content {
      account = include_map.value
    }
  }

  dynamic "exclude_map" {
    for_each = lookup(each.value, "exclude_account_ids", null) != null ? [1] : []

    content {
      account = exclude_map.value
    }
  }

  security_service_policy_data {
    type = "SHIELD_ADVANCED"

    managed_service_data = jsonencode({
      type = "SHIELD_ADVANCED"
    })
  }
}
