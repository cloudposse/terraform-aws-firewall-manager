module "dns_firewall_label" {
  for_each = local.dns_firewall_policies

  source  = "cloudposse/label/null"
  version = "0.25.0"

  attributes = [each.key]
  context    = module.this.context
}

resource "aws_fms_policy" "dns_firewall" {
  for_each = local.dns_firewall_policies

  name                        = module.dns_firewall_label[each.key].id
  delete_all_policy_resources = lookup(each.value, "delete_all_policy_resources", true)
  exclude_resource_tags       = lookup(each.value, "exclude_resource_tags", false)
  remediation_enabled         = lookup(each.value, "remediation_enabled", false)
  resource_type_list          = lookup(each.value, "resource_type_list", null)
  resource_type               = lookup(each.value, "resource_type", null)
  resource_tags               = lookup(each.value, "resource_tags", null)

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
    type = "DNS_FIREWALL"

    managed_service_data = jsonencode({
      type                  = "DNS_FIREWALL"
      preProcessRuleGroups  = lookup(each.value.policy_data, "pre_process_rule_groups", [])
      postProcessRuleGroups = lookup(each.value.policy_data, "post_process_rule_groups", [])
      }
    )
  }
}
