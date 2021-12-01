output "firewall_manager_admin_account_id" {
  value       = module.firewall_manager.admin_account.account_id
  description = "AWS Account ID of the designated admin account."
}
