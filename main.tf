locals {
  enabled                                = module.this.enabled
  admin_account_ids                      = local.enabled && length(var.admin_account_ids) > 0 ? var.admin_account_ids : [join("", data.aws_caller_identity.default.*.account_id)]
  security_groups_common_policies        = local.enabled && length(var.security_groups_common_policies) > 0 ? { for policy in flatten(var.security_groups_common_policies) : policy.name => policy } : {}
  security_groups_content_audit_policies = local.enabled && length(var.security_groups_content_audit_policies) > 0 ? { for policy in flatten(var.security_groups_content_audit_policies) : policy.name => policy } : {}
  security_groups_usage_audit_policies   = local.enabled && length(var.security_groups_usage_audit_policies) > 0 ? { for policy in flatten(var.security_groups_usage_audit_policies) : policy.name => policy } : {}
  shiled_advanced_policies               = local.enabled && length(var.shiled_advanced_policies) > 0 ? { for policy in flatten(var.shiled_advanced_policies) : policy.name => policy } : {}
  waf_policies                           = local.enabled && length(var.waf_policies) > 0 ? { for policy in flatten(var.waf_policies) : policy.name => policy } : {}
  waf_v2_policies                        = local.enabled && length(var.waf_v2_policies) > 0 ? { for policy in flatten(var.waf_v2_policies) : policy.name => policy } : {}
  dns_firewall_policies                  = local.enabled && length(var.dns_firewall_policies) > 0 ? { for policy in flatten(var.dns_firewall_policies) : policy.name => policy } : {}
  network_firewall_policies              = local.enabled && length(var.network_firewall_policies) > 0 ? { for policy in flatten(var.network_firewall_policies) : policy.name => policy } : {}
}

data "aws_caller_identity" "default" {
  count = local.enabled ? 1 : 0
}

resource "aws_fms_admin_account" "default" {
  for_each = toset(local.admin_account_ids)

  account_id = each.value
}
