output "firewall_manager_admin_account_id" {
  value = module.firewall_manager.admin_account.account_id
  description = "AWS Account ID of the designated admin account."
}

output "dns_firewall_ids" {
  value = module.firewall_manager.dns_firewall_ids
  description = "List of Policy DNS Firewall Rules IDs."
}

output "network_firewall_ids" {
  value = module.firewall_manager.network_firewall_ids
  description = "List of Policy Network Firewall Rules IDs."
}

output "security_groups_common_ids" {
  value = module.firewall_manager.security_groups_common_ids
  description = "List of Policy Security Group Common IDs."
}

output "security_groups_content_audit_ids" {
  value = module.firewall_manager.security_groups_content_audit_ids
  description = "List of Policy Security Content Audit IDs."
}

output "security_groups_usage_audit_ids" {
  value = module.firewall_manager.security_groups_usage_audit_ids
  description = "List of Policy Security Usage Audit IDs."
}

output "shield_advanced_ids" {
  value = module.firewall_manager.shield_advanced_ids
  description = "List of Policy Shield Advanced IDs."
}

output "waf_ids" {
  value = module.firewall_manager.waf_ids
  description = "List of WAF Policy IDs."
}

output "waf_v2_ids" {
  value = module.firewall_manager.waf_v2_ids
  description = "List of WAF v2 Policy IDs."
}
