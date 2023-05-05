module "waf_v2_label" {
  for_each = local.waf_v2_policies

  source  = "cloudposse/label/null"
  version = "0.25.0"

  attributes = [each.key]
  context    = module.this.context
}

resource "aws_fms_policy" "waf_v2" {
  for_each = local.waf_v2_policies

  name                        = module.waf_v2_label[each.key].id
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

  security_service_policy_data {
    type = "WAFV2"

    managed_service_data = jsonencode({
      type                  = "WAFV2"
      preProcessRuleGroups  = lookup(each.value.policy_data, "pre_process_rule_groups", [])
      postProcessRuleGroups = lookup(each.value.policy_data, "post_process_rule_groups", [])

      defaultAction = {
        type = upper(each.value.policy_data.default_action)
      }

      overrideCustomerWebACLAssociation = lookup(each.value.policy_data, "override_customer_web_acl_association", false)
      loggingConfiguration              = lookup(each.value.policy_data, "logging_configuration", local.logging_configuration)
    })
  }
}
