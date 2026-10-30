locals {
  enabled                                = module.this.enabled
  security_groups_common_policies        = local.enabled && length(var.security_groups_common_policies) > 0 ? { for policy in flatten(var.security_groups_common_policies) : policy.name => policy } : {}
  security_groups_content_audit_policies = local.enabled && length(var.security_groups_content_audit_policies) > 0 ? { for policy in flatten(var.security_groups_content_audit_policies) : policy.name => policy } : {}
  security_groups_usage_audit_policies   = local.enabled && length(var.security_groups_usage_audit_policies) > 0 ? { for policy in flatten(var.security_groups_usage_audit_policies) : policy.name => policy } : {}
  shield_advanced_policies               = local.enabled && length(var.shield_advanced_policies) > 0 ? { for policy in flatten(var.shield_advanced_policies) : policy.name => policy } : {}
  waf_policies                           = local.enabled && length(var.waf_policies) > 0 ? { for policy in flatten(var.waf_policies) : policy.name => policy } : {}
  waf_v2_policies                        = local.enabled && length(var.waf_v2_policies) > 0 ? { for policy in flatten(var.waf_v2_policies) : policy.name => policy } : {}
  dns_firewall_policies                  = local.enabled && length(var.dns_firewall_policies) > 0 ? { for policy in flatten(var.dns_firewall_policies) : policy.name => policy } : {}
  network_firewall_policies              = local.enabled && length(var.network_firewall_policies) > 0 ? { for policy in flatten(var.network_firewall_policies) : policy.name => policy } : {}


  # These are objects (not JSON strings): `managed_service_data` is JSON-encoded as a whole in `waf_v2.tf`,
  # and AWS FMS rejects a `loggingConfiguration` that is itself an encoded string.
  logging_config_firehose_arn     = { logDestinationConfigs : [var.firehose_arn], redactedFields : [{ redactedFieldType : "SingleHeader", redactedFieldValue : "Cookies" }, { redactedFieldType : "Method" }] }
  logging_config_firehose_enabled = { logDestinationConfigs : [join("", aws_kinesis_firehose_delivery_stream.firehose_stream[*].id)], redactedFields : [{ redactedFieldType : "SingleHeader", redactedFieldValue : "Cookies" }, { redactedFieldType : "Method" }] }

  logging_configuration = local.enabled ? (var.firehose_enabled ? local.logging_config_firehose_enabled : (var.firehose_arn != null ? local.logging_config_firehose_arn : null)) : null
}

resource "aws_fms_admin_account" "default" {
  count    = local.enabled && var.admin_account_enabled ? 1 : 0
  provider = aws.admin

  account_id = var.admin_account_id
}
