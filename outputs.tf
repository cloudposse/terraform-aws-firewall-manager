output "admin_account" {
  value       = aws_fms_admin_account.default
  description = "AWS Account ID of the designated admin account."
}

output "dns_firewall_ids" {
  value       = local.enabled ? aws_fms_policy.dns_firewall.*.id : []
  description = "List of Policy DNS Firewall Rules IDs."
}

output "network_firewall_ids" {
  value       = local.enabled ? aws_fms_policy.network_firewall.*.id : []
  description = "List of Policy Network Firewall Rules IDs."
}

output "security_groups_common_ids" {
  value       = local.enabled ? aws_fms_policy.security_groups_common.*.id : []
  description = "List of Policy Security Group Common IDs."
}

output "security_groups_content_audit_ids" {
  value       = local.enabled ? aws_fms_policy.security_groups_content_audit.*.id : []
  description = "List of Policy Security Content Audit IDs."
}

output "security_groups_usage_audit_ids" {
  value       = local.enabled ? aws_fms_policy.security_groups_usage_audit.*.id : []
  description = "List of Policy Security Usage Audit IDs."
}

output "shield_advanced_ids" {
  value       = local.enabled ? aws_fms_policy.shiled_advanced.*.id : []
  description = "List of Policy Shield Advanced IDs."
}

output "waf_ids" {
  value       = local.enabled ? aws_fms_policy.waf.*.id : []
  description = "List of WAF Policy IDs."
}

output "waf_v2_ids" {
  value       = local.enabled ? aws_fms_policy.waf_v2.*.id : []
  description = "List of WAF v2 Policy IDs."
}
