module "network_firewall_label" {
  for_each = local.network_firewall_policies

  source  = "cloudposse/label/null"
  version = "0.24.1"

  attributes = [each.key]
  context    = module.this.context
}

resource "aws_fms_policy" "network_firewall" {
  for_each = local.network_firewall_policies

  name                        = module.network_firewall_label[each.key].id
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
    type = "NETWORK_FIREWALL"

    managed_service_data = jsonencode({
      type                                           = "NETWORK_FIREWALL"
      networkFirewallStatelessRuleGroupReferences    = lookup(each.value.policy_data, "stateless_rule_group_references", [])
      networkFirewallStatelessDefaultActions         = lookup(each.value.policy_data, "stateless_default_actions", [])
      networkFirewallStatelessFragmentDefaultActions = lookup(each.value.policy_data, "stateless_fragment_default_actions", [])
      networkFirewallStatelessCustomActions          = lookup(each.value.policy_data, "stateless_custom_actions", [])
      networkFirewallStatefulRuleGroupReferences     = lookup(each.value.policy_data, "stateful_rule_group_references_arns", null) != null ? [for group in each.value.policy_data.stateful_rule_group_references_arns : { resourceARN = group }] : []
      networkFirewallOrchestrationConfig = {
        singleFirewallEndpointPerVPC = lookup(each.value.policy_data.orchestration_config, "single_firewall_endpoint_per_vpc", false)
        allowedIPV4CidrList          = lookup(each.value.policy_data.orchestration_config, "allowed_ipv4_cidrs", [])
      }
      }
    )
  }
}
