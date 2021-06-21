module "security_groups_common_label" {
  for_each = local.security_groups_common_policies

  source  = "cloudposse/label/null"
  version = "0.24.1"

  attributes = [each.key]
  context    = module.this.context
}

resource "aws_fms_policy" "security_groups_common" {
  for_each                    = local.security_groups_common_policies
  provider                    = aws.firewall_manager_admin
  name                        = module.security_groups_common_label[each.key].id
  delete_all_policy_resources = lookup(each.value, "delete_all_policy_resources", true)
  exclude_resource_tags       = lookup(each.value, "exclude_resource_tags", false)
  remediation_enabled         = lookup(each.value, "remediation_enabled", false)
  resource_type_list          = lookup(each.value, "resource_type_list")
  resource_tags               = lookup(each.value, "resource_tags", null)

  dynamic "include_map" {
    for_each = lookup(each.value, "include_map", null) != null ? [1] : []

    content {
      account = tolist(include_map.value)
    }
  }

  dynamic "exclude_map" {
    for_each = lookup(each.value, "exclude_map", null) != null ? [1] : []

    content {
      account = tolist(exclude_map.value)
    }
  }

  security_service_policy_data {
    type = "SECURITY_GROUPS_COMMON"

    managed_service_data = jsonencode({
      type                                     = "SECURITY_GROUPS_COMMON"
      revertManualSecurityGroupChanges         = lookup(each.value.managed_service_data, "revert_manual_security_group_changes", false)
      exclusiveResourceSecurityGroupManagement = lookup(each.value.managed_service_data, "exclusive_resource_security_group_management", false)
      applyToAllEC2InstanceENIs                = lookup(each.value.managed_service_data, "apply_to_all_ec2_instance_enis", false)
      securityGroups                           = lookup(each.value.managed_service_data, "security_groups", null) != null ? flatten([for sg in tolist(each.value.managed_service_data.security_groups) : { id = sg }]) : {}
    })
  }
}
